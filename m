Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBCAC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F24320675
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BEpDNdyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCGHvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:51:31 -0500
Received: from mail-pl1-f180.google.com ([209.85.214.180]:44556 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgCGHva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:51:30 -0500
Received: by mail-pl1-f180.google.com with SMTP id d9so1828955plo.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 23:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=72BokNb8+LRSUqSnxvdTJFvIWXTSEo6fEq3Gaxcb910=;
        b=BEpDNdyx71F/hSRDAJAun6HAJilAUYxlfls/m7UjSN+TFYEJloIyFSIHdSNYTVxKzz
         AjL3TQgsUdoqf4BQbAFPLf74QCsFrFrJB1W3Lqozw9LFMzUECsdwO50nVyPTeDOfEqbe
         /IWuGWiTYZ55XuxZ8j8OjLstHN+tEemVjYnAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=72BokNb8+LRSUqSnxvdTJFvIWXTSEo6fEq3Gaxcb910=;
        b=MX6073qQSo7JSmUKR0f6oGPdqR1+uPS312Ldt5VXyvhXH1sj59PxVaqLDsaBezBsmj
         M/YW7Z44zzf3c4dYUH5n5Zj7xViZqws34+5tkpVhIhLTi7aQR3yuMhn2Zm8fIpsiLtzh
         XOgHEpD5/QupVLqbMt6t1q76fDMfgB8CoNAw7dPn8g9WHbOJMs/Q9NaXecpxH/j85SYA
         jn+5eiaE+8d6HDnSdRdPd5KtLtwyIlINhBdtKGRkUF/6Qg3f3hfotV1FmiB1FpbqIgsc
         Wtig9/qsClNXemeJkUNw+ZqIfGklPaUt2NCiTioUxnjRuQubydQMw8/7X9T44RTJkM9k
         SUnA==
X-Gm-Message-State: ANhLgQ2au4eWdIsxjfWlA17DfrQBQLkkAGyn5efELdMOy2pzAOI8D6qF
        wkTTShhXOhzjZVSa/vMEGpZ7EQ==
X-Google-Smtp-Source: ADFU+vtTXPsliF19xRSptfi9Zpe5YBygsbKqgsfbJRHtpar7l8SNDU/a8t6xhuVE0ZHysXHaCVrXAg==
X-Received: by 2002:a17:90a:858c:: with SMTP id m12mr7480297pjn.127.1583567489536;
        Fri, 06 Mar 2020 23:51:29 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id h2sm7621630pjc.7.2020.03.06.23.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 23:51:28 -0800 (PST)
Date:   Sat, 7 Mar 2020 16:51:27 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4 05/11] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Message-ID: <20200307075127.GD176460@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-6-senozhatsky@chromium.org>
 <70144162-3bbe-4ea5-a3f7-e52d4585db53@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70144162-3bbe-4ea5-a3f7-e52d4585db53@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/06 16:30), Hans Verkuil wrote:
[..]
> >  
> >  /* capabilities for struct v4l2_requestbuffers and v4l2_create_buffers */
> > @@ -2446,7 +2449,8 @@ struct v4l2_create_buffers {
> >  	__u32			memory;
> >  	struct v4l2_format	format;
> >  	__u32			capabilities;
> > -	__u32			reserved[7];
> > +	__u32			flags;
> 
> The new flags argument needs to be documented in the command for struct v4l2_create_buffers.
> 

Will add.

	-ss
