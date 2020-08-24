Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD062C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E04F20768
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qs1NcdPf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgHXCJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgHXCJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:09:03 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1AAEC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:09:02 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ds1so3436920pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d2eI+Uva392DXSoTAeBOiAjgTaQAvkMUUuuDiI2QxaQ=;
        b=Qs1NcdPf3wLhZMVgKQLYgonH25LMcG0ojtpF8+a6Mc1ZU9B3dpCteoTSfiMBL8KE51
         PcQuLv31ETUtVc2AV1fDtJEwx+Pxe/I+olAZPxVC2Jq20ZdLYlSkeL2o1m4ArujTLlei
         T3E/1DUL/9HzhBCpW+oUBsDi/zt+COP9CDnMn8BSS5rJNLf6qrB6B2eu+yYI5St8jkvd
         I60vtkcE+rqJsb7Q8xUQifhc3zgO27EsLN03Nwrb4uA2ac/OQs0zXMCb0nKs+A+YKX4W
         pXx9R7Dv/lklZFG/M3ZEav2XkEbgaSq3KQF3ae+dLnYUhnqXL9xfUIn3OU4xi0yAOA6r
         QYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d2eI+Uva392DXSoTAeBOiAjgTaQAvkMUUuuDiI2QxaQ=;
        b=O0u6pWkgIxZZWYxiOPk3KGiV0/q4WGtxE2szVOSn4c0k+1BE/VEdgAntpWzaD5jcDL
         cuu+H1djaj3/FhEJkN0is+DaRsnibuVvbMhoTmoTLj6DUFt36uGHLfzWszVlntWURz4P
         zTOLg72ev5x0jCpMIkKkzNnfp5tCvYIoLsSEBwxy5gWfOtMQ6Mmy3NRQ50ci0IBYuJOO
         wy/0EN+Uz9kqhQ34jBxEbJbM+QwdBR5tgTmQQ2vI51IzmehHvpVpgx8hz8nL8ABb3qjH
         bGsK9dmttFva+3Kd+FWMGmkS+THZQxZJAEIOfkUiVI6o+NbUCmXUu6cv19Bh6qhebu+z
         tvyA==
X-Gm-Message-State: AOAM532tyRyT0358mRGTBQl/5hL7+VBHWRzaCsp7wE3jo46dL9yiou4W
        nTR774IKMA9X8WnRPJKN0jaf2xCj1ds=
X-Google-Smtp-Source: ABdhPJxf22gIxd//VcctDkAIvdYZrlFOjIhWdL44SCiisdE44DufILzAmX5puVXeSc61XGJV0YrLGw==
X-Received: by 2002:a17:902:7c15:: with SMTP id x21mr2318250pll.74.1598234942067;
        Sun, 23 Aug 2020 19:09:02 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q11sm9247272pfn.170.2020.08.23.19.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 19:09:00 -0700 (PDT)
Date:   Mon, 24 Aug 2020 11:08:58 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
Message-ID: <20200824020858.GA567@jagdpanzerIV.localdomain>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-2-john.ogness@linutronix.de>
 <20200820101625.GE4353@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820101625.GE4353@alley>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/08/20 12:16), Petr Mladek wrote:
> Now that I think about it. This is the biggest problem with any temporary buffer
> for pr_cont() lines. I am more and more convinced that we should just
> _keep the current behavior_. It is not ideal. But sometimes mixed
> messages are always better than lost ones.

Agreed. John, let's move this into a backlog for the time being? We can
continue discussions, but first let's fix the empty lines for cont line
print outs in the current dmesg output.

	-ss
