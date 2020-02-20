Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74CF4C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7C020659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 16:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="pbumDXdK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgBTQTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 11:19:52 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36500 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgBTQTv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 11:19:51 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so1091037pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 08:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UoTCfzqksuJam7QRA9BGeGPxWJUV9DRD7hHRl8gmjpY=;
        b=pbumDXdKkHuGQfUBc9P7m0nCawhVtAO2nF1jUxz4kuwUYPh66cyEEtVw5ddVC7vv5i
         cddTazMkznXynG9kB8z6xczhceq3+cpt4ZD4EXO5u/JBK6W1JcrRocpbUC1NaAXK420/
         IP0kwK8zi8DYC3ZTGIBkaCilpb4Z10L9NyHCQkOeGMzbQEGhiytyehTa6cYhNuXqmNZQ
         U6yhJTW6Llj2O/y4yGk+9+XHNk2RUgiSDHh0Hnt1CfbWP8tu21kJMZdIuXrOVFoUUz5i
         X8QXXuNhfzkYF4mGuepyCtdad6asxgvVFrMrRTgF+508N3rIHX01GMAjYdj+1nbf9+fB
         JElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UoTCfzqksuJam7QRA9BGeGPxWJUV9DRD7hHRl8gmjpY=;
        b=fGWjcvJ+GrSAECfmavorh98e52MDFV2vgR/fKOpFo1invZtK0pZ0/SoIfnoP+4bFno
         rB1NVROeL3m8pVN3oId2gjgu8B4Yf/iKhTURj1hzYbH/gbnDcliZ+tv9Mub2nbIqNVmu
         7soaDGqeafhKpilqdv9N2cRkzE72kYJ+o2N0G8vUEOIevZn7almpIDY+yzfiTh9Qzj94
         OpoI9W/iSjXLTcNVRzANPlgcFq0vJwexZCrJ1TMisKhJWZpvwpAjEkkExkrlqGO+dbPb
         zw61DIg3TMAMz/gR0MplDssEudQqyQi7nMLG8kxi5hee+++rWTf1uyifYJrXSGPZe3eS
         Cxyg==
X-Gm-Message-State: APjAAAUK1QAbYlhHoyS0CoswxRW+U6kuoWijsvlTI0leQ++Ly6pfJj/X
        OwQD+kMeDTOFPUXJsfygMrHOUf1s0V4=
X-Google-Smtp-Source: APXvYqxOlFbY7zbENyuhr1uTMtylYN+vYUp8QpTslnZ+u3u/T3KF45Jx9i+uAc3vhtzWYxNcOQ8/4g==
X-Received: by 2002:a17:90b:309:: with SMTP id ay9mr4380351pjb.22.1582215589636;
        Thu, 20 Feb 2020 08:19:49 -0800 (PST)
Received: from ?IPv6:2605:e000:100e:8c61:8495:a173:67ea:559c? ([2605:e000:100e:8c61:8495:a173:67ea:559c])
        by smtp.gmail.com with ESMTPSA id x4sm60949pff.143.2020.02.20.08.19.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 08:19:48 -0800 (PST)
Subject: Re: [PATCH liburing] man/io_uring_setup.2: fix 'sq_thread_idle'
 description
To:     Stefano Garzarella <sgarzare@redhat.com>
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200220140833.108791-1-sgarzare@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <c3ec6bc8-bb4a-699b-8dd4-8ccb7788f445@kernel.dk>
Date:   Thu, 20 Feb 2020 08:19:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220140833.108791-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/20 7:08 AM, Stefano Garzarella wrote:
> In the kernel we are using msecs_to_jiffies() to convert the
> 'sq_thread_idle' parameter, provided by the user, in jiffies.
> So, the value is interpreted in milliseconds and not microseconds.

Applied, thanks.

-- 
Jens Axboe

