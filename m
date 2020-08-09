Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339CDC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 12:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06B6B206B6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 12:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTHDEmTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgHIMEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 08:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgHIMEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 08:04:00 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC22C061756;
        Sun,  9 Aug 2020 05:03:58 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k4so6411281oik.2;
        Sun, 09 Aug 2020 05:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=shlQp1wjE1XxBoGStGkK9AaTHBgjr+gaPgDeknFSfFc=;
        b=hTHDEmTCwgn9ZDFTzW7gQGrO/+oyhCBqDn5fnCI7qHgPxmknjcxzVNfOmSLAgXDzwi
         ekfeAjbnrTRCDwaGaYEik0xM7Jhe4uFzwVB6Q2nGi0yoUBuSXoUlQjhQUrwi7VeUC1w0
         9XdmX9M2eTDwCl6vGyyaAZs9kmK/DrX0uNp8wOkIj2rrOtJCfTqEnwTm96AhNJoYBuvL
         1m3F9tjQ1Plahx+NE8Sxj6yogeFl2Vec9tMN85J6E9MX3IzehgTAT4BUV0/yBRdmg999
         SDBeQgSxU/w5vaoH0TeqSuz622wCsA2xdxPZ8Xw22aUf20cbqpeAL7P6X9v2yXj7Y5rG
         4SwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=shlQp1wjE1XxBoGStGkK9AaTHBgjr+gaPgDeknFSfFc=;
        b=NW9lxzkvAN7aRRcmClLUpV8XZhsua5Za9MCnJlEYcChlsPOSpxKpmLV/zcvnn8/oxy
         Ew1kqq4NaiPw1gEan+jq+CTxjTct5HMHN8xxnwwHCBS0wc8oBRQnhj31nT2n0EmzNnyV
         wJaolQX0ku+AdEHJeVEIPMhml2phmQNxWefVCL8TFdS2lKX609HP/vknvcAdjQ80/uju
         x8kxGRPJzLYyKAluEkjl3j8fzPkdJ/41Alu22in8HnxYzzMTqdOxAuz9nNevu9menod9
         AORWF46dMiUk5tTaEImQ7uhW86BtC9t5ChJ9fUpR+T4iHafyeMFUBOqMqK0qj3QeFnDO
         744Q==
X-Gm-Message-State: AOAM533lOZMTd/kwZAbPzwcaFTbSGXvQmBk287pBq9pDFgXZ/WXnA/lj
        6G/YcYZ/06Ngw0VsgozPv3WBoStqq/eW+ZI7EJY=
X-Google-Smtp-Source: ABdhPJx5be5ic7ZZLoDuhiHBBXuazwIppkvk5OoiBVrH58FNay6Svw5gfaVxTCt2bRWQgkURf8AEJT7Fjmgt9iSoKfU=
X-Received: by 2002:a05:6808:b03:: with SMTP id s3mr18814427oij.154.1596974636517;
 Sun, 09 Aug 2020 05:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200730082022.5557-1-colin.king@canonical.com>
 <CAFCwf101gsf3GK6f_ggNgPeKTFXEDdCYz-LugNq5mY342zc2Hw@mail.gmail.com>
 <20200731062057.GC1508201@kroah.com> <CAFCwf11oAg=mhsqwnSh7vHuUeJEpEtBFKggFaRcbOFY8PhPsPA@mail.gmail.com>
 <20200809120238.GC385599@kroah.com>
In-Reply-To: <20200809120238.GC385599@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Sun, 9 Aug 2020 15:03:28 +0300
Message-ID: <CAFCwf12sj7GcQL-0zLd+F5bxigwPmon23zc+o_gHf0qZPjOyeQ@mail.gmail.com>
Subject: Re: [PATCH][next] habanalabs: fix incorrect check on failed workqueue create
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Colin King <colin.king@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>, Tomer Tayar <ttayar@habana.ai>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        kernel-janitors@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 3:02 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sun, Aug 09, 2020 at 02:02:18PM +0300, Oded Gabbay wrote:
> > On Fri, Jul 31, 2020 at 9:21 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Thu, Jul 30, 2020 at 01:51:48PM +0300, Oded Gabbay wrote:
> > > > On Thu, Jul 30, 2020 at 11:20 AM Colin King <colin.king@canonical.com> wrote:
> > > > >
> > > > > From: Colin Ian King <colin.king@canonical.com>
> > > > >
> > > > > The null check on a failed workqueue create is currently null checking
> > > > > hdev->cq_wq rather than the pointer hdev->cq_wq[i] and so the test
> > > > > will never be true on a failed workqueue create. Fix this by checking
> > > > > hdev->cq_wq[i].
> > > > >
> > > > > Addresses-Coverity: ("Dereference before null check")
> > > > > Fixes: 5574cb2194b1 ("habanalabs: Assign each CQ with its own work queue")
> > > > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > > > ---
> > > > >  drivers/misc/habanalabs/common/device.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
> > > > > index be16b75bdfdb..35214a186913 100644
> > > > > --- a/drivers/misc/habanalabs/common/device.c
> > > > > +++ b/drivers/misc/habanalabs/common/device.c
> > > > > @@ -288,7 +288,7 @@ static int device_early_init(struct hl_device *hdev)
> > > > >         for (i = 0 ; i < hdev->asic_prop.completion_queues_count ; i++) {
> > > > >                 snprintf(workq_name, 32, "hl-free-jobs-%u", i);
> > > > >                 hdev->cq_wq[i] = create_singlethread_workqueue(workq_name);
> > > > > -               if (hdev->cq_wq == NULL) {
> > > > > +               if (hdev->cq_wq[i] == NULL) {
> > > > >                         dev_err(hdev->dev, "Failed to allocate CQ workqueue\n");
> > > > >                         rc = -ENOMEM;
> > > > >                         goto free_cq_wq;
> > > > > --
> > > > > 2.27.0
> > > > >
> > > >
> > > > This patch is:
> > > > Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
> > > >
> > > > Greg, can you please apply it directly to the char-misc-next branch ?
> > > > I don't want to send a pull request for 1 patch.
> > >
> > > Already merged :)
> >
> > Hi Greg,
> > I can't find this patch in char-misc-next.
> > Can you please check if you applied it ?
>
> Oops, you are right, I did not take it, my fault, sorry.
>
> > If not, I'll apply it to my fixes tree and send it to you for -rc2
>
> That would be great, thanks for following up on this.
>
> greg k-h

Sure, np.
Thanks,
Oded
