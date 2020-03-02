Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B7EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE40A2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 18:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583174462;
	bh=fK4GgKY74zmllaLHPCom9FMGUrRcLJEgKYt9nhJZLMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EYX+8ZAl6DroyfCgdBNsvueBqCnSfP/ZfzYhUZXwrq+23N6ihL86cqDJMHXFmLyHI
	 gnopDzDp3SzCT++D4aYB2n0EYndJItH3a9v5KogCMefhudnU2cuQbxPi6TuF6zlRm4
	 V7zDFLx+57hOW7XqvCtpEP72uwVneZ9K2FpNoDIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbgCBSlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:41:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45852 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgCBSlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 13:41:01 -0500
Received: by mail-pl1-f195.google.com with SMTP id b22so111306pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 10:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iTiPsXu4VK8wclZJX+LGxfmXHy1UzTMMV42yt+UyNwY=;
        b=mXXxf+EwzILSGbwwkm4gw7EWpR8zNo7cow+ah0oNlXDVD5eFQ9mAnLb/oPV9rXT8N1
         gYV3TYzBjpfakkTMSY2DJ8cir297cGb1mD9zbrw/pwmxb157knpswebjotXwjpD/3GLP
         4jVZVrYoH7JMdWdIfEaR3z1i6OX49QSoONE75Y0bThLhAFKPxiImL0E0mbWimjvea8XZ
         IEmz951Iw+a09JgDW3VYKk/4gHJqXG5bxLNl6GUPilA08ily+qq4b1RZaBkzsa0x2LFn
         Gut5EgsdOjGUAiLtmRs3jXMgWZhJ33uzH0nqd4Nm48yrr0Emr6qo0LYkQYs8q6/cmt5R
         y1Dw==
X-Gm-Message-State: ANhLgQ2flcZtMsoICh2uf/Rz+RkDCh1tpezayf/iBZjlTDp8tjSFw5cb
        8UdNICRM0MyT8FPBqFC1SfY=
X-Google-Smtp-Source: ADFU+vs/OgVecAQVIsjJRAe2y6lknoTbeaaK1I85P7kQxo2kqeW6ZXaJIYxSJquV3E+1O8a/Ck9T/Q==
X-Received: by 2002:a17:90a:678e:: with SMTP id o14mr328705pjj.24.1583174459958;
        Mon, 02 Mar 2020 10:40:59 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id l10sm170590pjy.5.2020.03.02.10.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 10:40:58 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id A35164035F; Mon,  2 Mar 2020 18:40:57 +0000 (UTC)
Date:   Mon, 2 Mar 2020 18:40:57 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     sunjunyong <sunjy516@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        sunjunyong@xiaomi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: fix a double abort case with
 fw_load_sysfs_fallback
Message-ID: <20200302184057.GB11244@42.do-not-panic.com>
References: <1582876593-27926-1-git-send-email-sunjunyong@xiaomi.com>
 <20200228130735.GA11244@42.do-not-panic.com>
 <20200302092301.GA25139@mi-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302092301.GA25139@mi-OptiPlex-7050>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 05:23:01PM +0800, sunjunyong wrote:
> Hi Luis:
> 
> This issue is caused by concurrent situation like below:
> when thread 1# wait firmware loading, thread 2# may write -1 to abort
> loading and wakeup thread 1# before it timeout.  so
> wait_for_completion_killable_timeout of thread 1# would return
> remaining time which is != 0 with fw_st->status FW_STATUS_ABORTED.
> And the results would be converted into err -ENOENT in
> __fw_state_wait_common and transfered to fw_load_sysfs_fallback in
> thread 1#.  The -ENOENT means firmware status is already at ABORTED,
> so fw_load_sysfs_fallback no need to get mutex to abort again.
> BTW,the double abort issue would not cause kernel panic but slow down
> it sometimes.

OK so just clarify in your patch's commit log that without your change
you'd just abort twice, it would not create an issue, and the change is
just a minor optimization.

Can you re-submit with that change?

  Luis

> -----------------------------
> thread 1#,wait for loading
> fw_load_sysfs_fallback
>  ->fw_sysfs_wait_timeout
>     ->__fw_state_wait_common
>        ->wait_for_completion_killable_timeout
> 
> in __fw_state_wait_common,
> ...
> 93	ret = wait_for_completion_killable_timeout(&fw_st->completion, timeout);
> 94	if (ret != 0 && fw_st->status == FW_STATUS_ABORTED)
> 95		return -ENOENT;
> 96	if (!ret)
> 97		return -ETIMEDOUT;
> 98
> 99	return ret < 0 ? ret : 0;
> -----------------------------
> thread 2#, write -1 to abort loading
> firmware_loading_store
>  ->fw_load_abort
>    ->__fw_load_abort
>      ->fw_state_aborted
>        ->__fw_state_set
>          ->complete_all 
> 
> in __fw_state_set,
> ...
> 111         if (status == FW_STATUS_DONE || status == FW_STATUS_ABORTED)
> 112                 complete_all(&fw_st->completion);
> ...
> -----------------------------
> On Fri, Feb 28, 2020 at 01:07:35PM +0000, Luis Chamberlain wrote:
> > On Fri, Feb 28, 2020 at 03:56:33PM +0800, Junyong Sun wrote:
> > > fw_sysfs_wait_timeout may return err with -ENOENT
> > > at fw_load_sysfs_fallback and firmware is already
> > > in abort status, no need to abort again, so skip it.
> > 
> > What exactly is caused by this issue though? Are you seeing
> > a kernel panic, some extra messages in the kernel log? This
> > informationw ould be useful for the kernel commit log.
> > 
> > > Signed-off-by: Junyong Sun <sunjunyong@xiaomi.com>
> > > ---
> > >  drivers/base/firmware_loader/fallback.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> > > index 8704e1b..1e9c96e 100644
> > > --- a/drivers/base/firmware_loader/fallback.c
> > > +++ b/drivers/base/firmware_loader/fallback.c
> > > @@ -525,7 +525,7 @@ static int fw_load_sysfs_fallback(struct fw_sysfs *fw_sysfs,
> > >  	}
> > >  
> > >  	retval = fw_sysfs_wait_timeout(fw_priv, timeout);
> > > -	if (retval < 0) {
> > > +	if (retval < 0 && retval != -ENOENT) {
> > >  		mutex_lock(&fw_lock);
> > >  		fw_load_abort(fw_sysfs);
> > >  		mutex_unlock(&fw_lock);
> > > -- 
> > > 2.7.4
> > > 
