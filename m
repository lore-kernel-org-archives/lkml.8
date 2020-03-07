Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 481D3C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20B902070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 09:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DgAHZ+jh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGJiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 04:38:05 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:40649 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgCGJiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 04:38:05 -0500
Received: by mail-pj1-f65.google.com with SMTP id gv19so2164025pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 01:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xgm+vlDt9tYOqUwFznd38xlWEF7FNzt6k+k3ObuJ1kY=;
        b=DgAHZ+jhVSQxjb/Z2xyuvTHfOSirzcsHebExJpG6TJQ+d8rBPmsZ18XUaspC1WjvJS
         6IxsVXk5OyTckehNRnPot+D9e+S3Kvn48H7XghgA3E+hgbQv/1xQcpfnh2pQW6q8KEyN
         RzxbcG0DvS31h/hQ/0C+29mwPRVBmkiACA1QI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xgm+vlDt9tYOqUwFznd38xlWEF7FNzt6k+k3ObuJ1kY=;
        b=aLdv/SsyUqKBp0xD2OUPFjob82BK/VLPS+2KpWamxCqzj7u6KqM1feIk2krymAxxwH
         eWW+Hor0DY23hVtcvC4jCVEEtAHHmt5RTLrK6P+ENP3J0M+yOyjWnvJnhtX3Q4VjNefw
         ouwB6cPWHwZFItYLGXK1zQhHfZVzxybJ1+e3XyPVKpLUnpT1ri7g8kCpEnVp1+VSk6Dw
         9l6k3ukCkEHL6qRnWU5z+GEXza1rPv+Hhb+8HZwCDaDlUzf/lrTzAuV96iRu3JJh8kFr
         gNam2BqXyf8fGXkhf7eOsQbX8LY4DXwzTfYZu8oOLvhxmjyIBid5aRUAYgPXEK0BEmBJ
         lcGA==
X-Gm-Message-State: ANhLgQ1uSNsDCWmjAo/0wwfTJYGw14Chl4wxWVkK270LsullTsyJkX2k
        jafP7QiFj8v1mXg9vyGWHkujFQ==
X-Google-Smtp-Source: ADFU+vvwb0DDLHcnVLokBUhb8ulXe7fYoKuQfgjLRmo8/MSYTNbBubhgnZ+ppY9NwYkh1sxCNWNtOg==
X-Received: by 2002:a17:90a:3ab0:: with SMTP id b45mr8260362pjc.9.1583573882596;
        Sat, 07 Mar 2020 01:38:02 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id x19sm15089504pfc.144.2020.03.07.01.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 01:38:01 -0800 (PST)
Date:   Sat, 7 Mar 2020 18:38:00 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCHv4 05/11] videobuf2: handle
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Message-ID: <20200307093800.GA191261@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-6-senozhatsky@chromium.org>
 <70144162-3bbe-4ea5-a3f7-e52d4585db53@xs4all.nl>
 <20200307075127.GD176460@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307075127.GD176460@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/07 16:51), Sergey Senozhatsky wrote:
> On (20/03/06 16:30), Hans Verkuil wrote:
> [..]
> > >  
> > >  /* capabilities for struct v4l2_requestbuffers and v4l2_create_buffers */
> > > @@ -2446,7 +2449,8 @@ struct v4l2_create_buffers {
> > >  	__u32			memory;
> > >  	struct v4l2_format	format;
> > >  	__u32			capabilities;
> > > -	__u32			reserved[7];
> > > +	__u32			flags;
> > 
> > The new flags argument needs to be documented in the command for struct v4l2_create_buffers.
> > 

Hans, what does "command for struct v4l2_create_buffers" mean?

BTW, I added v4l2_create_buffers::flags comment:

---

diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
index 12b1bd220347..c6c1cccbb5c1 100644
--- a/include/uapi/linux/videodev2.h
+++ b/include/uapi/linux/videodev2.h
@@ -2441,6 +2441,8 @@ struct v4l2_dbg_chip_info {
  * @memory:	enum v4l2_memory; buffer memory type
  * @format:	frame format, for which buffers are requested
  * @capabilities: capabilities of this buffer type.
+ * @flags:	additional buffer management attributes (ignored if queue
+ *		does not have V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS capability).
  * @reserved:	future extensions
  */
 struct v4l2_create_buffers {
