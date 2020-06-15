Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94AB0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 626F62071A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+tq2D9Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731541AbgFOUzg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:55:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21540 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726207AbgFOUze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592254532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=OYiL5f6t2DoVF2iRwtKmMIV+W5WN0++ZzqGnAHQLfG0=;
        b=V+tq2D9QlYE9YmQHT9xKEvgbhuOhA2ND6H1AN8qFTvkBGtrS86ofB37PkoRzFvxpu0qVbm
        L4TH7aLkDtpJgUTkQFoQ+XNsyzmIKWi6IBlo5pTYCHU+TBPwlHywpIpJty9ghYkdbl/hQW
        OCo+vdFC7fzu1WMG+hpEvEChN6fQGTk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-3kelbY72OWKiQosmcPH3tQ-1; Mon, 15 Jun 2020 16:55:28 -0400
X-MC-Unique: 3kelbY72OWKiQosmcPH3tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C69A873405;
        Mon, 15 Jun 2020 20:55:27 +0000 (UTC)
Received: from [10.10.114.150] (ovpn-114-150.rdu2.redhat.com [10.10.114.150])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75BC3768AA;
        Mon, 15 Jun 2020 20:55:26 +0000 (UTC)
Subject: Re: [Patch v1] i40e: limit the msix vectors based on housekeeping
 CPUs
To:     "Keller, Jacob E" <jacob.e.keller@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "jlelli@redhat.com" <jlelli@redhat.com>
References: <20200615202125.27831-1-nitesh@redhat.com>
 <20200615202125.27831-2-nitesh@redhat.com>
 <02874ECE860811409154E81DA85FBB58C25F8001@FMSMSX102.amr.corp.intel.com>
From:   Nitesh Narayan Lal <nitesh@redhat.com>
Autocrypt: addr=nitesh@redhat.com; prefer-encrypt=mutual; keydata=
 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
 VujM7c/b4pps
Organization: Red Hat Inc,
Message-ID: <bef0c237-b349-9499-9cf8-ad8b10f5ff59@redhat.com>
Date:   Mon, 15 Jun 2020 16:55:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <02874ECE860811409154E81DA85FBB58C25F8001@FMSMSX102.amr.corp.intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oXmH9LDtUOaZu5Owd4qYz5KQq9SeJwmpJ"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oXmH9LDtUOaZu5Owd4qYz5KQq9SeJwmpJ
Content-Type: multipart/mixed; boundary="t5ZUkl7FZIqTqMYEkUlLodjXA4RR8Cjan"

--t5ZUkl7FZIqTqMYEkUlLodjXA4RR8Cjan
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US


On 6/15/20 4:48 PM, Keller, Jacob E wrote:
>
>> -----Original Message-----
>> From: Nitesh Narayan Lal <nitesh@redhat.com>
>> Sent: Monday, June 15, 2020 1:21 PM
>> To: linux-kernel@vger.kernel.org; frederic@kernel.org; mtosatti@redhat.c=
om;
>> sassmann@redhat.com; Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; K=
eller,
>> Jacob E <jacob.e.keller@intel.com>; jlelli@redhat.com
>> Subject: [Patch v1] i40e: limit the msix vectors based on housekeeping C=
PUs
>>
>> In a realtime environment, it is essential to isolate
>> unwanted IRQs from isolated CPUs to prevent latency overheads.
>> Creating MSIX vectors only based on the online CPUs could lead
>> to a potential issue on an RT setup that has several isolated
>> CPUs but a very few housekeeping CPUs. This is because in these
>> kinds of setups an attempt to move the IRQs to the limited
>> housekeeping CPUs from isolated CPUs might fail due to the per
>> CPU vector limit. This could eventually result in latency spikes
>> because of the IRQ threads that we fail to move from isolated
>> CPUs. This patch prevents i40e to add vectors only based on
>> available online CPUs by using housekeeping_cpumask() to derive
>> the number of available housekeeping CPUs.
>>
>> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
>> ---
> Ok, so the idea is that "housekeeping" CPUs are to be used for general pu=
rpose configuration, and thus is a subset of online CPUs. By reducing the l=
imit to just housekeeping CPUs, we ensure that we do not overload the syste=
m with more queues than can be handled by the general purpose CPUs?

Yes.
General purpose or the housekeeping CPUs or the non-isolated CPUs.

>
> Thanks,
> Jake
>
--=20
Nitesh


--t5ZUkl7FZIqTqMYEkUlLodjXA4RR8Cjan--

--oXmH9LDtUOaZu5Owd4qYz5KQq9SeJwmpJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkXcoRVGaqvbHPuAGo4ZA3AYyozkFAl7n4D0ACgkQo4ZA3AYy
ozniNg//VHimUukZC0EdnF8hxx1yZ96/bDkBJ0Ys1U6ZEfKK4mXIu7PEh5jMJ83F
4KPp/LK8gIB/0K1MWiVlATv4s90NqECUsbAvgh7IHGb/8X61FL/STlbXRH5TJG+W
pN5JFy9YrLgArI0ziY6LR3BrDfY/tGl3u0aDeG10bAHVWqECo8U0bxZsW9q97LFO
QME7AsxQKnKpjBaAbFcX5j/GJo4fg/xqyPa8Y/k/E03qAl4SNz+/NxACRis0hCNV
dUzNmS/kzY3VkmG7zTKUMbKrWPT6VGnRdmPYW7NtPWTUcYEEH7PoZoBAM9UdChI5
5x7PR69SmJZ4+4lHZFAQ/vlNo/z04LuRM9jwSrAF59j2uj+5jDGPAM4v122503G+
JWfjRvzy2dUdhyVXkyPwlzm7AJ/mVEAPuvqvVyqDE9DhAIc6lTIyPrWK+H27dRje
lQlBynfj0o4LT9virt00pgky9awYzyfo/V0bvjKqkQQe4Fb+gNN2vouR/bN6hdM8
2kSO6PKBpFsXpx1NrLA6HgQsKLwo85b/AbOUzSl97uHatHIWmIgA3VjbBt7xUOxq
C3iE17Vm/fPXXTwWnCjgxRP73AqInb7rUkKHZIv8+DiBcvfWj2gfy58OdVe+89cZ
06fn/7QudeqS60adomZfjQvzze54mi9WsQMTdWdxnYeF+nBP9ag=
=Zz2B
-----END PGP SIGNATURE-----

--oXmH9LDtUOaZu5Owd4qYz5KQq9SeJwmpJ--

