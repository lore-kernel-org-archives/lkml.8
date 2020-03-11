Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26696C4CC9E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31882072F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qxv1kSHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgCKRf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:35:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37852 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgCKRfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:35:55 -0400
Received: by mail-wr1-f66.google.com with SMTP id 6so3744984wre.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ul3aKF3mgmNSrCiKZR1xszeDpKLTrhtBGKS0nAOe96I=;
        b=Qxv1kSHhmiyl18Lg2mWDZPGmXfwOrbANLmtvAgLq2LDLT4t5EMSGVFbTQ0T7HnVUVC
         /El7DtDiEORVt9HKOrXAvI53eA3ZjgKAh3xoy5kjaVBE2OwCQPnczmJXs2UCRN58QwEY
         nrOpJ/cQR0ULP4WPL/gjVtx2SnEEjvJp610a6X85Ou8I0za0dBWskFn4m+JdxiaEEc8i
         IFgGTtV7w7h/D7nm4FAlQn0lvzYNfHdCon//XQInYH1YHgMmu6IqVsBKjL0wl4YLoVq4
         2+DCA5uZrFKQoWq5nY5ISU1UlfRZCd32gjj6Da0JK1KvIBa8ky1OTK6lh2qDENVtMezh
         UFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ul3aKF3mgmNSrCiKZR1xszeDpKLTrhtBGKS0nAOe96I=;
        b=U4FEctP9Z++dazJmQSnSObPUZQjq+gFLP/RmBAi+XKHesDqsJA+0d3B6YaK7p6HnQV
         O0XHelTQQ3qSl1x5Gued922N10jWFKpgc6iHbX82sWqKWAwMvYlJctbj9ZSZsEIePQy6
         C93r0pULHsSaM8ez3Cw/Fc56+ZrxXz26z+IbIVY/zpXjY+54paYk7DO/auUaXdxANhBs
         xGf4q2aSaSLIvC1ayU3pM/pXtJ5fHUb/WROMZszN3WDMfbvgYYuPW92zFFxRe9srb27s
         Kn4LhuMB9xu0CqXSnDjicGU6zGDn7pCiBIyjqYgvbXUe99UCAVpqJKdNcoMck60IOQG/
         BpzQ==
X-Gm-Message-State: ANhLgQ1guU9S24l/7odh/gFDncnAa9W81vKFZpp5GUsiZqD2Ljn78WJU
        WQW9YgD4TCCPGJWYTB0DCw==
X-Google-Smtp-Source: ADFU+vsjpr414bIBPts3KWkhIsaYHeKBASQZ7NLY183Ib+uUwl1ipw/yJLNpNo/BaGgh+eB9SQ8QUQ==
X-Received: by 2002:adf:e447:: with SMTP id t7mr5687572wrm.374.1583948154005;
        Wed, 11 Mar 2020 10:35:54 -0700 (PDT)
Received: from avx2 ([46.53.249.42])
        by smtp.gmail.com with ESMTPSA id y69sm9437327wmd.46.2020.03.11.10.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:35:53 -0700 (PDT)
Date:   Wed, 11 Mar 2020 20:35:50 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     akpm@linux-foundation.org, labbott@redhat.com,
        sumit.semwal@linaro.org, minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com
Subject: Re: [RFC PATCH 1/3] proc/meminfo: introduce extra meminfo
Message-ID: <20200311173550.GA2170@avx2>
References: <20200311034441.23243-1-jaewon31.kim@samsung.com>
 <CGME20200311034454epcas1p184680d40f89d37eec7f934074c4a9fcf@epcas1p1.samsung.com>
 <20200311034441.23243-2-jaewon31.kim@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311034441.23243-2-jaewon31.kim@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 12:44:39PM +0900, Jaewon Kim wrote:
> Provide APIs to drivers so that they can show its memory usage on
> /proc/meminfo.
> 
> int register_extra_meminfo(atomic_long_t *val, int shift,
> 			   const char *name);
> int unregister_extra_meminfo(atomic_long_t *val);

> +			show_val_kb(m, memtemp->name_pad, nr_page);

I have 3 issues.

Can this be printed without "KB" piece and without useless whitespace,
like /proc/vmstat does?

I don't know how do you parse /proc/meminfo.
Do you search for specific string or do you use some kind of map[k] = v
interface?

2) zsmalloc can create top-level symlink and resolve it to necessary value.
It will be only 1 readlink(2) system call to fetch it.

3) android can do the same

For simple values there is no need to register stuff and create
mini subsystems.

	/proc/alexey
