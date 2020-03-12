Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7128C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A890F2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 10:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgCLKtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 06:49:24 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:36005 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726023AbgCLKtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 06:49:23 -0400
X-IronPort-AV: E=Sophos;i="5.70,544,1574118000"; 
   d="scan'208";a="439991803"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:49:21 +0100
Date:   Thu, 12 Mar 2020 11:49:20 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Stefano Brivio <sbrivio@redhat.com>
cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        daniel.baluta@gmail.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH] Staging: rtl8723bs: rtw_mlme: Remove
 unnecessary conditions
In-Reply-To: <20200312113416.23d3db5c@elisabeth>
Message-ID: <alpine.DEB.2.21.2003121145540.2418@hadrien>
References: <20200311135859.5626-1-shreeya.patel23498@gmail.com> <61a6c3d7-6592-b57b-6466-995309302cc2@linux.microsoft.com> <20200312113416.23d3db5c@elisabeth>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 12 Mar 2020, Stefano Brivio wrote:

> Hi Lakshmi,
>
> On Wed, 11 Mar 2020 19:42:06 -0700
> Lakshmi Ramasubramanian <nramas@linux.microsoft.com> wrote:
>
> > On 3/11/2020 6:58 AM, Shreeya Patel wrote:
> >
> > > Remove unnecessary if and else conditions since both are leading to the
> > > initialization of "phtpriv->ampdu_enable" with the same value.
> > >
> > > Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> >
> > Stating this based on the patch descriptions I have seen.
> > Others, please advise\correct me if I am wrong.
> >
> > Patch description should state the problem first[1] and then describe
> > how that is fixed in the given patch.
> >
> > For example:
> >
> > In the function rtw_update_ht_cap(), phtpriv->ampdu_enable is set to the
> > same value in both if and else statements.
> >
> > This patch removes this unnecessary if-else statement.
>
> That's my general preference as well, but I can't find any point in the
> "Describe your changes" section of submitting-patches.rst actually
> defining the order. I wouldn't imply that from the sequence the steps
> are presented in.
>
> In case it's possible to say everything with a single statement as
> Shreeya did here, though, I guess that becomes rather a linguistic
> factor, and I personally prefer the concise version here.

https://kernelnewbies.org/PatchPhilosophy suggests:

In patch descriptions and in the subject, it is common and preferable to
use present-tense, imperative language. Write as if you are telling git
what to do with your patch.

It provides the following as an example of a good description:

    somedriver: fix sleep while atomic in send_a_packet()

    The send_a_packet() function is called in atomic context but takes a mutex,
    causing a sleeping while atomic warning.  Change the skb_lock to be a spin
    lock instead of a mutex to fix.

So this illustrates the order that Lakshmi suggests, even though I don't
think that order is ever suggested explicitly.  On the other hand it
avoids "This patch...", which would add some clutter, in my opinion.

julia

>
> --
> Stefano
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200312113416.23d3db5c%40elisabeth.
>
