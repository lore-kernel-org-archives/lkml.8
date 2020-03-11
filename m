Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65164C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66E95206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:44:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W8NOfb6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbgCKXoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:44:15 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40081 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCKXoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:44:15 -0400
Received: by mail-pj1-f66.google.com with SMTP id bo3so375601pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZEyMFnwakXjowg52voyfC4K3NxCZ17Ctu1QUhRXYRT8=;
        b=W8NOfb6IhTJDTK4NvVVTnkeUUX2ZTACR57qIAAHhHfGsO3drKSin6f6/Eok7XkrVlw
         IpO9S1AFMRPavhBJ3WAjnWiuNfpqSNzNqrvYwAiaIzvId7JI1ML0iN1C7ZmUKdJWvbBe
         fBqCRf8EZXV1zJFJGestM93RMkTsIBi/TdKxa9aAqx0jQOCS7T8arUXRKV4XOgrAR8yn
         QGccrmcsZakfUaSPqTi7uWuuCm0SNGECwnn2JRRkm6rmblfPxZnxprZuawaZeq7R1Gzk
         ELb52TpQbdcpXTbqqggA1AoKCUSj+ZlNy7003gdOEprd+7OUgKiF6dmnEdVdtB+kw3Q5
         FsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZEyMFnwakXjowg52voyfC4K3NxCZ17Ctu1QUhRXYRT8=;
        b=JqK5mdF4OMewCz0iBruw1iunE0WZ9kxdDnBOHF7aCc7jYexkeCRGxKDrqqFiylZjMz
         XgtLF1oyMO9I3viA1KFBdiGT+UclTBLiFEQplBNaMTPfOwMQgNiTD5duksAqbi5d2Bve
         mVuWfLfH6dUYA9vlWPM/M+TMfhguzCSj33mH9Vd6TnFkMywtPaQ0LoO7T48unbKx8LNR
         Qvsc2vILE/7EvrzBDKGVO2g2IFw96XZAm4sY89MoN+qF0saPceNGbq/wr0/X8W5hdQee
         zSNM3XMiPLA1DMX8ZvoKqMVraAZWjSoeqe83dem0yAmEZjw+8LlwVlr/TtA7MUKmUn1v
         gQCQ==
X-Gm-Message-State: ANhLgQ2cmObMELg9l1LtweZxg5bUmcgPI4QPt8QGjGkpz03aEsYU+sw8
        NUBs83xPa1ATFZ5GIQTFxSCLOQ==
X-Google-Smtp-Source: ADFU+vvAYHKzghO9JCb5F1g7p3KD/ZAgT/OiCQR+XEJpn5yw5f7PbqaSvpjVtk5PgBOjn8wT814SRQ==
X-Received: by 2002:a17:902:5ac9:: with SMTP id g9mr5114278plm.69.1583970252383;
        Wed, 11 Mar 2020 16:44:12 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h2sm1173651pgq.32.2020.03.11.16.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 16:44:11 -0700 (PDT)
Date:   Wed, 11 Mar 2020 16:44:09 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Alex Elder <elder@linaro.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] remoteproc: re-check state in
 rproc_trigger_recovery()
Message-ID: <20200311234409.GH14744@builder>
References: <20200228183359.16229-1-elder@linaro.org>
 <20200228183359.16229-2-elder@linaro.org>
 <20200309205633.GF1399@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309205633.GF1399@xps15>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 09 Mar 13:56 PDT 2020, Mathieu Poirier wrote:

> On Fri, Feb 28, 2020 at 12:33:56PM -0600, Alex Elder wrote:
> > Two places call rproc_trigger_recovery():
> >   - rproc_crash_handler_work() sets rproc->state to CRASHED under
> >     protection of the mutex, then calls it if recovery is not
> >     disabled.  This function is called in workqueue context when
> >     scheduled in rproc_report_crash().
> >   - rproc_recovery_write() calls it in two spots, both of which
> >     the only call it if the rproc->state is CRASHED.
> > 
> > The mutex is taken right away in rproc_trigger_recovery().  However,
> > by the time the mutex is acquired, something else might have changed
> > rproc->state to something other than CRASHED.
> 
> I'm interested in the "something might have changed" part.  The only thing I can
> see is if rproc_trigger_recovery() has been called from debugfs between the time
> the mutex is released but just before rproc_trigger_recovery() is called in
> rproc_crash_handler_work().  In this case we would be done twice, something your
> patch prevents.  Have you found other scenarios?
> 

Alex is right, by checking rproc->state outside of the lock
rproc_recovery_write() allows for multiple contexts to enter
rproc_trigger_recovery() at once.

Further more, these multiple context will be held up at the
mutex_lock_interruptible() and as each one completes the recovery the
subsequent ones will stop the rproc, generate a coredump and then start
it again.


This patch would be to fix the latter problem and allows the next patch
to move the check in the debugfs interface in under the mutex. As such
I've picked up patch 1, 2 and 4.

Regards,
Bjorn

> Thanks,
> Mathieu
> 
> > 
> > The work that follows that is only appropriate for a remoteproc in
> > CRASHED state.  So check the state after acquiring the mutex, and
> > only proceed with the recovery work if the remoteproc is still in
> > CRASHED state.
> > 
> > Delay reporting that recovering has begun until after we hold the
> > mutex and we know the remote processor is in CRASHED state.
> > 
> > Signed-off-by: Alex Elder <elder@linaro.org>
> > ---
> >  drivers/remoteproc/remoteproc_core.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
> > index 097f33e4f1f3..d327cb31d5c8 100644
> > --- a/drivers/remoteproc/remoteproc_core.c
> > +++ b/drivers/remoteproc/remoteproc_core.c
> > @@ -1653,12 +1653,16 @@ int rproc_trigger_recovery(struct rproc *rproc)
> >  	struct device *dev = &rproc->dev;
> >  	int ret;
> >  
> > +	ret = mutex_lock_interruptible(&rproc->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* State could have changed before we got the mutex */
> > +	if (rproc->state != RPROC_CRASHED)
> > +		goto unlock_mutex;
> > +
> >  	dev_err(dev, "recovering %s\n", rproc->name);
> >  
> > -	ret = mutex_lock_interruptible(&rproc->lock);
> > -	if (ret)
> > -		return ret;
> > -
> >  	ret = rproc_stop(rproc, true);
> >  	if (ret)
> >  		goto unlock_mutex;
> > -- 
> > 2.20.1
> > 
