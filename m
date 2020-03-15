Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DC4C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34AA120578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 20:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgCOU32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 16:29:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:59084 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729103AbgCOU31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 16:29:27 -0400
Received: from [2001:8b0:7bc4:6b97:e0:2819:e4a9:bc26] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1jDZsv-0002Wj-IP; Sun, 15 Mar 2020 20:29:21 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1jDZsu-00Cj5t-LV; Sun, 15 Mar 2020 20:29:20 +0000
Message-ID: <17c4273e4f72ebdf1ca838d75fc6ed93fcdc7287.camel@decadent.org.uk>
Subject: Re: [PATCH] genirq: fix reference leaks on irq affinity notifiers
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Edward Cree <ecree@solarflare.com>, tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, psodagud@codeaurora.org
Date:   Sun, 15 Mar 2020 20:29:16 +0000
In-Reply-To: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com>
References: <24f5983f-2ab5-e83a-44ee-a45b5f9300f5@solarflare.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-JlXvKGw58ywoDQvIE0ys"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:8b0:7bc4:6b97:e0:2819:e4a9:bc26
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-JlXvKGw58ywoDQvIE0ys
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-13 at 20:33 +0000, Edward Cree wrote:
> The handling of notify->work did not properly maintain notify->kref in tw=
o
>  cases:
> 1) where the work was already scheduled, another irq_set_affinity_locked(=
)
>    would get the ref and (no-op-ly) schedule the work.  Thus when
>    irq_affinity_notify() ran, it would drop the original ref but not the
>    additional one.
> 2) when cancelling the (old) work in irq_set_affinity_notifier(), if ther=
e
>    was outstanding work a ref had been got for it but was never put.

This makes sense, but...

> Fix both by checking the return values of the work handling functions
>  (schedule_work() for (1) and cancel_work_sync() for (2)) and put the
>  extra ref if the return value indicates preexisting work.
>=20
> Fixes: cd7eab44e994 ("genirq: Add IRQ affinity notifiers")
> Fixes: 59c39840f5ab ("genirq: Prevent use-after-free and work list corrup=
tion")
> Signed-off-by: Edward Cree <ecree@solarflare.com>

...since the pending work item holds a reference to the notification
state, it's still not clear to me why or whether "genirq: Prevent use-
after-free and work list corruption" was needed.

If it's reasonable to cancel_work_sync() when removing a notifier, I
think we can remove the kref and call the release function directly.

Ben.

> ---
>  kernel/irq/manage.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index 7eee98c38f25..b3aa1db895e6 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -323,7 +323,10 @@ int irq_set_affinity_locked(struct irq_data *data, c=
onst struct cpumask *mask,
> =20
>  	if (desc->affinity_notify) {
>  		kref_get(&desc->affinity_notify->kref);
> -		schedule_work(&desc->affinity_notify->work);
> +		if (!schedule_work(&desc->affinity_notify->work))
> +			/* Work was already scheduled, drop our extra ref */
> +			kref_put(&desc->affinity_notify->kref,
> +				 desc->affinity_notify->release);
>  	}
>  	irqd_set(data, IRQD_AFFINITY_SET);
> =20
> @@ -423,7 +426,9 @@ irq_set_affinity_notifier(unsigned int irq, struct ir=
q_affinity_notify *notify)
>  	raw_spin_unlock_irqrestore(&desc->lock, flags);
> =20
>  	if (old_notify) {
> -		cancel_work_sync(&old_notify->work);
> +		if (cancel_work_sync(&old_notify->work))
> +			/* Pending work had a ref, put that one too */
> +			kref_put(&old_notify->kref, old_notify->release);
>  		kref_put(&old_notify->kref, old_notify->release);
>  	}
> =20
--=20
Ben Hutchings
Humour is the best antidote to reality.


--=-JlXvKGw58ywoDQvIE0ys
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl5ukBwACgkQ57/I7JWG
EQn1ZBAApI7JVGGlTyiiI8s0uC0Pj8iXltiS0ux2eyjNDvL3wtpiTUmrmvL4DaEw
b0trnwuDzuA5/YmJhJT0Bo9YBWl0XtS1+MyWzwBTj5FJVSqARPPHeUVOsFFDkS2F
oqGQ/r40R7kmxgayIV2n8g6vUacz/0nsWdiRk/z2JLRzyzIQwOORSga+WYjvM4qy
PL9afknmEytWiAj3t2CJSh+UI91YLOAbsRzbeTmDWlmy2AXzk+76VM3gPiroF8dx
rDmsMBrHzZPLbyEmxoXlrygMdI+xa8bBS3wC9L9CJFP77wr0evqlmYl1pmNJJrl+
EbtqgP+GUpKSEA1ngN3bnxB8nK/3wE5bb9C9I/gMOVhDfY5rPgYTxdEKK5mUncaW
3Iuvfh3pJ9L7c10EPqcqF1ReKUydNEPdW+Eo0YRpDdzSQmOJY6DzIOsyJlyDKxut
H275kjkEptAi+6mvCW+IZ36k0jtq0kE57mLw9pwxl5/A81KzkEZdVgXMQisa0Vq2
wWqdXaxP6n8+5V29a5KXaqsj+MoEr+0DpcFpeeUGp2KsjN6iHo1LiyWR/cpiTkV0
MoFKNVXFKz8sLWxzhqUBT3KFFYMTYBi4rHMdH565rLAO1aoO40Si5u7lmFjOKRfO
vJJn//8v0j/gjFOAtYwNK+G6sM7WaqHPmr631tVfbU2VMkqGMhc=
=+qZf
-----END PGP SIGNATURE-----

--=-JlXvKGw58ywoDQvIE0ys--
