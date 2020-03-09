Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F2FC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B924F2072A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 09:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RCzJvzds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbgCIJ30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 05:29:26 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:32947 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCIJ30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 05:29:26 -0400
Received: by mail-pg1-f175.google.com with SMTP id m5so4462185pgg.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 02:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GyFtCdRxR6sVhw72KswIK0rDXamwneP6LD6kWfJp1pc=;
        b=RCzJvzdseBmJqOvEfcFOWx3FDbQWFcOvN13MelV3ubCWasbOfIICbV1Xt8Cl+IGAxp
         VCF4OHvnNBa/q6tTTGlZpBO3DwbV0vGrgUTGApyfClRP8Ot5HaP3ddHTqb0llWbUIN7t
         TsJpvI0gFscNO/nvlU/TpFcSiRunodUd5MRrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GyFtCdRxR6sVhw72KswIK0rDXamwneP6LD6kWfJp1pc=;
        b=L+/73id8pptr7efDNKAtBlLFU2f5LyTDL6V0MNxKc5xZpbmBtuRvVioq/08glFnAN9
         uLMqQUVIM5rPN2mzOdhlKhNatsGMoJ3R2PsCRq4elFFFH4cT3eCnxU7jRb/HmCwBYTcr
         Zxh8qBEDF5NH5CdIJNPU5GcBeMVAL11GJz6ba4L4nhD9hkEjfEytAC7vt5PbEQWbqnrP
         /8Z58V6rTeRSFkbzP6VdNxgZNuwry3GH3X3w1y/SqaKuMseYVQnHDeOoCka9IpyU8qEV
         hqDpagcoQ8f87SSzjwAiU0MkIIbnIcy2007TcFtETLDRXis3Um+psJSGoPeBowVrB8BJ
         AMmg==
X-Gm-Message-State: ANhLgQ0fKGftJ0UZAWh2E+0neWrXSDdPb/9ERPFpVvOYQ13uT17tLxue
        w+L9TBCs14X/4XG3rqLmHUC6AQ==
X-Google-Smtp-Source: ADFU+vsk2pdMU3AJSsduLv1AvRkyUmXAC+5jInBmomYPmE3cw6Hj6w2NZASekEuWgdN18gXfuZcSFA==
X-Received: by 2002:a65:669a:: with SMTP id b26mr15435134pgw.24.1583746164892;
        Mon, 09 Mar 2020 02:29:24 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id a3sm21102522pfi.161.2020.03.09.02.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 02:29:24 -0700 (PDT)
Date:   Mon, 9 Mar 2020 18:29:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: Re: [PATCHv4 01/11] videobuf2: add cache management members
Message-ID: <20200309092922.GB231920@google.com>
References: <6f5916dd-63f6-5d19-13f4-edd523205a1f@xs4all.nl>
 <20200307112838.GA125961@google.com>
 <a4d85ac3-0eea-bc19-cd44-0c8f5b71f6bc@xs4all.nl>
 <20200309032707.GA9460@google.com>
 <40cd09d9-49a6-2159-3c50-825732151221@xs4all.nl>
 <20200309072526.GC46830@google.com>
 <e31197b6-5d22-0c3a-cc77-e9506136ada5@xs4all.nl>
 <CAAFQd5Ajopb019HZmtNJfDZmZbssDHfztmT0BvAD07QttXmZ1g@mail.gmail.com>
 <20200309090802.GA231920@google.com>
 <CAAFQd5BH2rFZkABej+JfW76f2tjmBBKWm8WjW+TOTBjfewm_9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5BH2rFZkABej+JfW76f2tjmBBKWm8WjW+TOTBjfewm_9w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/03/09 18:17), Tomasz Figa wrote:
> 
> I think that's fine, but we need to make it explicit. :)
> 

I'll improve Docs.

	-ss
