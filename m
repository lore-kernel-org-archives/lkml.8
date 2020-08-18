Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5166C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB4620706
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597759310;
	bh=UPYNOE1fTUq6nftlsWgimnfBgSq0ipHEEplvkeAhMKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qOEV/VXjG2Exu1Yz30zhGgzLioqqrzLO24gyfSa1tj2Sq4y2m9mKrPGbn1wjnAQxm
	 LySOfFiBlslxj9cmlqXTmq/Amf0ASUcY3cXyE2Vq8X50NAO2qcEhqUaRA1gPfUMDrN
	 QiAuPlNpMlz80UKmzOqjclD77grRiyO6LB4JL+7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgHROBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:01:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgHROBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:01:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4792C20706;
        Tue, 18 Aug 2020 14:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597759305;
        bh=UPYNOE1fTUq6nftlsWgimnfBgSq0ipHEEplvkeAhMKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7Thd5r2sdzbG+01QHiutP3X24Vlgdboh9jGho7cp86YzWzVZJHifPSrltWF5xK0v
         EOrDPfGko5PQPHCfpOeOfBT62oOL7SoTU+2YlByZaaBtFADHIxrfMFBMOcPaPmo+5K
         aWqjcpfF4lcrXeGvtZ4rrjE8k0JWQNMpq11aVYWM=
Date:   Tue, 18 Aug 2020 16:02:09 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?B?Suly9G1l?= Pouiller <jerome.pouiller@silabs.com>
Cc:     Tomer Samara <tomersamara98@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: wfx: refactor to avoid duplication at
 hif_tx.c
Message-ID: <20200818140209.GA547677@kroah.com>
References: <20200805121442.GA31953@tsnow>
 <2040746.q8W4dvF0dS@pc-42>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2040746.q8W4dvF0dS@pc-42>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:38:33AM +0200, Jérôme Pouiller wrote:
> Hello Tomer,
> 
> On Wednesday 5 August 2020 14:14:42 CEST Tomer Samara wrote:
> > 
> > Add functions wfx_full_send(), wfx_full_send_no_reply_async(),
> > wfx_full_send_no_reply() and wfx_full_send_no_reply_free()
> > which works as follow:
> > wfx_full_send() - simple wrapper for both wfx_fill_header()
> >                   and wfx_cmd_send().
> > wfx_full_send_no_reply_async() - wrapper for both but with
> >                                  NULL as reply and size zero.
> > wfx_full_send_no_reply() - same as wfx_full_send_no_reply_async()
> >                            but with false async value
> > wfx_full_send_no_reply_free() - same as wfx_full_send_no_reply()
> >                                 but also free the struct hif_msg.
> > 
> > Signed-off-by: Tomer Samara <tomersamara98@gmail.com>
> > ---
> > Changes in v2:
> >  - Changed these functions to static
> > 
> > drivers/staging/wfx/hif_tx.c | 180 ++++++++++++++++-------------------
> >  1 file changed, 80 insertions(+), 100 deletions(-)
> > 
> > diff --git a/drivers/staging/wfx/hif_tx.c b/drivers/staging/wfx/hif_tx.c
> > index 5110f9b93762..17f668fa40a0 100644
> > --- a/drivers/staging/wfx/hif_tx.c
> > +++ b/drivers/staging/wfx/hif_tx.c
> > @@ -40,7 +40,7 @@ static void wfx_fill_header(struct hif_msg *hif, int if_id,
> > 
> >  static void *wfx_alloc_hif(size_t body_len, struct hif_msg **hif)
> >  {
> > -       *hif = kzalloc(sizeof(struct hif_msg) + body_len, GFP_KERNEL);
> > +       *hif = kzalloc(sizeof(*hif) + body_len, GFP_KERNEL);
> 
> This change is not related to the rest of the patch. It should probably be
> split out.
> 
> >         if (*hif)
> >                 return (*hif)->body;
> >         else
> > @@ -123,9 +123,39 @@ int wfx_cmd_send(struct wfx_dev *wdev, struct hif_msg *request,
> >         return ret;
> >  }
> > 
> > +static int wfx_full_send(struct wfx_dev *wdev, struct hif_msg *hif, void *reply,
> > +                        size_t reply_len, bool async, int if_id, unsigned int cmd,
> > +                        int size)
> > +{
> > +       wfx_fill_header(hif, if_id, cmd, size);
> > +       return wfx_cmd_send(wdev, hif, reply, reply_len, async);
> > +}
> 
> This function takes 8 parameters. Are you sure it simplifies the code?
> 
> In add, it does two actions: modify hif and send it. I would keep these
> two actions separated.
> 
> > +
> > +static int wfx_full_send_no_reply_async(struct wfx_dev *wdev, struct hif_msg *hif, int if_id,
> > +                                       unsigned int cmd, int size, bool async)
> > +{
> > +       return wfx_full_send(wdev, hif, NULL, 0, async, if_id, cmd, size);
> > +}
> 
> Does it make sense to have a parameter 'async' to
> wfx_full_send_no_reply_async()? It is weird to call this function with
> async=false, no?
> 
> > +
> > +static int wfx_full_send_no_reply(struct wfx_dev *wdev, struct hif_msg *hif, int if_id,
> > +                                 unsigned int cmd, int size)
> > +{
> > +       return wfx_full_send_no_reply_async(wdev, hif, if_id, cmd, size, false);
> > +}
> > +
> > +static int wfx_full_send_no_reply_free(struct wfx_dev *wdev, struct hif_msg *hif, int if_id,
> > +                                      unsigned int cmd, int size)
> > +{
> > +       int ret;
> > +
> > +       ret = wfx_full_send_no_reply(wdev, hif, if_id, cmd, size);
> > +       kfree(hif);
> > +       return ret;
> > +}
> 
> One more time, sending the data and releasing are unrelated actions.
> Indeed, it saves a few lines of code, but is it really an improvement?
> 
> > +
> >  // This function is special. After HIF_REQ_ID_SHUT_DOWN, chip won't reply to any
> >  // request anymore. We need to slightly hack struct wfx_hif_cmd for that job. Be
> > -// carefull to only call this funcion during device unregister.
> > +// careful to only call this function during device unregister.
> 
> Not related to the rest of the patch.
> 
> [...]
> 
> As it stands, I think this change does not improve the code. Obviously, it
> is a subjective opinion. What the other developers think about it?

I agree with you, this just makes things more complex for no good
reason.

Now dropped from my review queue.

thanks,

greg k-h
