Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0044C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E2C21D81
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:38:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ey0mK4Yb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgF2Sia (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:38:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54681 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728001AbgF2Si0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593455905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHpi71bUs+BsFjt8lZpD5Zr/LhS7ZMFqT7wmicuY/G4=;
        b=ey0mK4YbeuIEekdKB7cilZT/m64yCDABLxXJmxmMQ8FD8ZHZ643M+CjDEhC1s0NUCpXxeU
        lWMXryJOyjBYHueKlldyICCLq5BNEqu+aqqDoa394etmaT4Uc7WM5J0OxmFTzs2tCaT6PX
        0La8sj73AYTdnUF0ORe0xF8LR/U+Ovo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-hRgcptoqM2e3s-QWOF21rA-1; Mon, 29 Jun 2020 08:36:56 -0400
X-MC-Unique: hRgcptoqM2e3s-QWOF21rA-1
Received: by mail-wm1-f71.google.com with SMTP id s134so18373492wme.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 05:36:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WHpi71bUs+BsFjt8lZpD5Zr/LhS7ZMFqT7wmicuY/G4=;
        b=e4scJy0wwIof+eDEjONZhRBmsz9Wiz3kIHZG0+wB/rJGG1GX4BaqorlcrN0J16eYHF
         Wgsb1Qx1hr/vJgCKJczasX0gnXEdW+cdqQ4o5EapM2yrw2cgNKFzwDjkkA/XRtfWF8Lv
         D7Ovh4lQSVH/eOdoM1hLCXnq6cxrGAgejxEhFcnkATt9I8JDdZUBoEwGBKqM1PdbgbG2
         V7Q3zhr+oujJ61Vo/daQyFhcDUkJ6xD4IY6cIzPhLXVe2RK7EVRQKJQd2sRlyN/crhIC
         PP7dnDJvSG4KM2eOJXS2CNno0M7gdZ6QkOErk+/JkW2tM10t60I8cunjCQWLWLUb8aVR
         DPEw==
X-Gm-Message-State: AOAM533YhgPFWgf5M7OJdgel5390HE+R/92oQtvmTJ5PZQ+vZ1sABpMf
        clax6MMa3Sg52KEFyurq4jgWWAr4VWIW6W5nCEYguh9JwAzyDclpqtXq0+kp85dmHAmZmh941rY
        k4DzXVk/RaLWSQi0M2otk+KH+
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr16815153wro.396.1593434214945;
        Mon, 29 Jun 2020 05:36:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTx7LfFE8q7hjqx4sIXbqUDdUdli4nLgY52lQdgIrkk3Z5wFL9rc+EmKrFXHY64KwYGSE0Bw==
X-Received: by 2002:adf:f0c5:: with SMTP id x5mr16815141wro.396.1593434214699;
        Mon, 29 Jun 2020 05:36:54 -0700 (PDT)
Received: from localhost.localdomain ([151.29.8.241])
        by smtp.gmail.com with ESMTPSA id c65sm28169085wme.8.2020.06.29.05.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 05:36:53 -0700 (PDT)
Date:   Mon, 29 Jun 2020 14:36:51 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200629123651.GA9670@localhost.localdomain>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
 <20200615210743.GA21371@lenoir>
 <20200616065757.GA446382@localhost.localdomain>
 <20200616204649.GA4914@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616204649.GA4914@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 16/06/20 22:46, Frederic Weisbecker wrote:
> On Tue, Jun 16, 2020 at 08:57:57AM +0200, Juri Lelli wrote:
> > Sure. Let me know if you find anything.
> 
> I managed to reproduce. With "threadirqs" and without
> "tsc=reliable". I see tons of spurious TIMER softirqs.
> Investigation begins! I'll let you know.

Gentle ping. Any new findings about this issue?

Thanks,

Juri

