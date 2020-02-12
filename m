Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CB2FC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEE6F24677
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 21:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541257;
	bh=VWbG3kOzQFAGLiumi7MxTlsk7I5CJvTlTyAtZqrbJ0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AKLzGfjwny5cQgznRDMZsbgSwpPUvw2tSF6i8H7nohtY6D4VOUitQTFZS3kglghig
	 GEUBhlOxB3RFixstmoKqfe1y+Fd+7SrCcilcqxuOFDKTCmMBB7N+r3B6fpJzsa+mUC
	 CWXjbuuyswyuy0E3Vf/9v+l0HDma5qyzAr73+m0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgBLVA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 16:00:57 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36419 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBLVA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 16:00:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id w25so3549331qki.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 13:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QYFIaWFzsqPfjxceen0fVSlty2UB/KqW13+wWsiWW6E=;
        b=PROc7air4m09zIbya5HKUlY9I+dp4Nt81lPVCm9cBr1KrU647UAgzeKJRxtQTL9aZS
         7H3/QaNW89Mhq/R9MxnWySA60HoxQvNJTRtiXQXz66Y3xFWMCRtlfVZNQbyQ0Ym0zDD/
         RYG/ZxEUg/er9ecly3md/ywcvmIPsQaBgwdArN+NU6LJiYcRnISInMQpjROYAXSKWLP2
         n8PdSfBea5n38kNA98sR3mmyorVCuRD5IHEIWtNfMVig/5oSeljM6PybiDcwi49tu64j
         m6m0R932F3yK7JmqcuYk1ABMRbHguAwbCudbJ5vBQBF/WvuzMJDJznVZfGf+09zlanlC
         nmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QYFIaWFzsqPfjxceen0fVSlty2UB/KqW13+wWsiWW6E=;
        b=DmMmVMCJxmXDS76u/Epfr3QW3OVLaMM5XcDpyZSxDNHDqEQ3GVpqdHTME2TJA2HEr9
         QTm5ke3uTeNAoBwPCZvdL1p5sKuVBGaKeTxsZ/LByXQfC5DybtnFILJ5vwkjL4ZmNeJ0
         CPk91JrxW7sfIMQQ/sbDK1rSr5w7F1kndZ9u1kJKBzxT1mPjN5spOiwLMoZDhASqX3Z/
         JZ+DnPG1QjkruhZ680VXvkvH3/dA4b/m/nAyTwRkg2d/zYwPnrH39bTnM3Mb4W54MKOd
         cpu8+EJiEZu9CaYJYRoDDMqszLR8qd4bTupu2oetFYcV5q3XJWJXUbWmQ2taFlT53sHb
         p3vg==
X-Gm-Message-State: APjAAAWEvDGSrZrY9g5P4hHSQOdEP2pTS/lTJSyb3Bir3mV3hrnIo9dB
        CgwwVEv8Yiz6ooARDUwRNPE=
X-Google-Smtp-Source: APXvYqxIokLaugGkW6a2VqccbGw2c5wlCKCUVIFrdJzyJ4aB6x4Et3V0aolY5gB5wtye0L1tXhjBGg==
X-Received: by 2002:ae9:ed4a:: with SMTP id c71mr12864628qkg.501.1581541254673;
        Wed, 12 Feb 2020 13:00:54 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id c45sm197431qtd.43.2020.02.12.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 13:00:54 -0800 (PST)
Date:   Wed, 12 Feb 2020 16:00:53 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2] workqueue: Document (some) memory-ordering properties
 of {queue,schedule}_work()
Message-ID: <20200212210053.GA80993@mtj.thefacebook.com>
References: <20200122183952.30083-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122183952.30083-1-parri.andrea@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 07:39:52PM +0100, Andrea Parri wrote:
> It's desirable to be able to rely on the following property:  All stores
> preceding (in program order) a call to a successful queue_work() will be
> visible from the CPU which will execute the queued work by the time such
> work executes, e.g.,
> 
>   { x is initially 0 }
> 
>     CPU0                              CPU1
> 
>     WRITE_ONCE(x, 1);                 [ "work" is being executed ]
>     r0 = queue_work(wq, work);          r1 = READ_ONCE(x);
> 
>   Forbids: r0 == true && r1 == 0
> 
> The current implementation of queue_work() provides such memory-ordering
> property:
> 
>   - In __queue_work(), the ->lock spinlock is acquired.
> 
>   - On the other side, in worker_thread(), this same ->lock is held
>     when dequeueing work.
> 
> So the locking ordering makes things work out.
> 
> Add this property to the DocBook headers of {queue,schedule}_work().
> 
> Suggested-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
> Acked-by: Paul E. McKenney <paulmck@kernel.org>

Applied to wq/for-5.7.

Thanks.

-- 
tejun
