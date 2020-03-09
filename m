Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B91C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996DB20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 04:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g98VXD5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIEDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 00:03:10 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180]:41915 "EHLO
        mail-pl1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgCIEDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 00:03:09 -0400
Received: by mail-pl1-f180.google.com with SMTP id t14so3427442plr.8
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 21:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MePM1LXmB9zu10CipKCKT3AOCH0ORjlABBFj6iXCvwo=;
        b=g98VXD5fWvExJ1O1zTNwK2U30AXvWKVY+rszXkxQb4p4RypmzbUbGoKjultjn8YWKf
         Cc3+YRCE/xZo+6pNSg6+mUgMRDvTBTafPeUbeaTFY8+iPw7E2FSjUlKTW0xmBEcG81ci
         KmijLJmDOXv2p0lOtqJIWLKmTWgITI9OSPx5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MePM1LXmB9zu10CipKCKT3AOCH0ORjlABBFj6iXCvwo=;
        b=qGc/scSIZUjtZ7B3TWvqAgwVjo0AKisqSgmY5JJ6unN9Qe2HN6758cnI411aiqoBfN
         8v1wyaX+7s1bgHcdsgWW5lDIyhkLT7Rf8LdLytdNjsafv12+KfG13G3C7m+QGoyDHtr5
         MKoQflhzbr9D6k46Rr+jvp9gaXUFfLfSiI1MRXWt1GY3RDfWH28vSFHlISQSWBBkzUNw
         paBLnxb5yEq2bZksKeLjS30IVTlfLUhKvkKty92m15F2pfmRKNfQFBidzS3aT0rqjMp1
         8EmXygWlRJJbmS2eMwIRAkldwNEAIwniHCLjN4m80BhKMHytUBB2U5m7B8N0jWcVOgsi
         ZvEw==
X-Gm-Message-State: ANhLgQ0yjCnotibpOt4sM1AtUbI9pDggQ3nj29gqirZN90RdrbNizMiL
        inOkPnfTKMcKkQnv+gbuKW6wkQ==
X-Google-Smtp-Source: ADFU+vtw1v/LUtTzhPiRwFAG99XIoB6s3/fRb+QC53epenxq92s4BOkmVBFa4hEM9XaA1/1M7jNzkg==
X-Received: by 2002:a17:90a:8586:: with SMTP id m6mr16360811pjn.121.1583726587196;
        Sun, 08 Mar 2020 21:03:07 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id l13sm16686316pjq.23.2020.03.08.21.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 21:03:06 -0700 (PDT)
Date:   Mon, 9 Mar 2020 13:03:05 +0900
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
Subject: Re: [PATCHv4 01/11] videobuf2: add cache management members
Message-ID: <20200309040305.GB9460@google.com>
References: <20200302041213.27662-1-senozhatsky@chromium.org>
 <20200302041213.27662-2-senozhatsky@chromium.org>
 <17060663-9c30-de5e-da58-0c847b93e4d3@xs4all.nl>
 <20200307094634.GB29464@google.com>
 <6f5916dd-63f6-5d19-13f4-edd523205a1f@xs4all.nl>
 <20200307112838.GA125961@google.com>
 <a4d85ac3-0eea-bc19-cd44-0c8f5b71f6bc@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d85ac3-0eea-bc19-cd44-0c8f5b71f6bc@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/07 12:47), Hans Verkuil wrote:
> 
> 1) attempting to use V4L2_FLAG_MEMORY_NON_CONSISTENT will clear the flag
>    upon return (test with both reqbufs and create_bufs).
> 2) attempting to use V4L2_BUF_FLAG_NO_CACHE_INVALIDATE or V4L2_BUF_FLAG_NO_CACHE_CLEAN
>
[..]
>
> All these tests can be done in testReqBufs().

MEMORY_NON_CONSISTENT is a queue property, we set it during queue setup.
NO_CACHE_INVALIDATE/FLAG_NO_CACHE_CLEAN is a buffer property, we set it
when we qbuf. I'm not sure if all of these can be done in testReqBufts().

	-ss
