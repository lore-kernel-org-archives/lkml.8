Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C0CC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D628C20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:52:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjHfbveP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbgAPWw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:52:29 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34798 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729261AbgAPWw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:52:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so10675152pgf.1;
        Thu, 16 Jan 2020 14:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=RN/ipqsW8ngLEOa2AfLfo6np6isK0Qy4a7Uo/MWPYEE=;
        b=FjHfbvePrYUdqCds+yuzsoCVo1x8DAPJvd39MzZwN3sCHQHWbwvKxoRwv0535mp52f
         wATGB9SALyJ4lqQ7Je33fM1SxDHKZ5H1D1EDHtSlf7GWtWF0NojyEp37Opv5LMZIyqn+
         wmRzwa7jrQdUSP1ku69l1wgxDWqOX/EzCmhgaaXXGRy+0OiWPtYpPEqDiSiSrxipGzQW
         Brmh56ElnzgcMYIVZliEbDos6nMVE3RnOC72w0UWFMV5e8gafIuxmF+mv6XmbLNdWpJH
         FOoaD+JtyysCRId4CYAyPKM/H8ob6gQGtQPAzE4kqPFPLdRA54fqcvRlo9M2nhQipIFZ
         LliA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=RN/ipqsW8ngLEOa2AfLfo6np6isK0Qy4a7Uo/MWPYEE=;
        b=ZkxONNG388Z9Bu7xMsuCWyiQZ7yVCk0FcZNYVJ8Xv7R1BkeINXbA6Knbwy9Zh05Nig
         uxyc4QpeykuBY8QA0BeQ9a8FATSs4AsgkK8FQ8sfdAPQY3U6m8rTilkX3UPacn0buG45
         x/PcMa/MlyIMV+ON5mD4y5nD2FWbXwpFIxwSzn5OtldsquS8PlNHQnAhy4IIDfFV4Kvf
         y2Q80E0QiriyGrCrvIAPVQd0xDffBcOeovt9oTXkicSEN6y5b7POTbMk08Duafx/Kr5P
         NYIKMkOTPNaE2SLV1ApMWgSRCmlJ+ltBo30e1VyiLPY5HmBfIbEj4K53LzrMYhFyARf/
         RYAA==
X-Gm-Message-State: APjAAAWXfSVxyIWd1vyvVXMAjKonPDRkwTkdrIhcUAdusxMC8RpXnVdm
        5AQMd3rcd746GBstqAnUC5Hq7OxU
X-Google-Smtp-Source: APXvYqzZM8E4S1IGKY2/NPb/C7G2BXIYHoYjQFEL8s7115ygbnLtKV1asqltwhHSqGsOw3K86lWq6Q==
X-Received: by 2002:a62:e318:: with SMTP id g24mr39141152pfh.218.1579215148082;
        Thu, 16 Jan 2020 14:52:28 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c15sm5232268pja.30.2020.01.16.14.52.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 14:52:27 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:52:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
Cc:     clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
Message-ID: <20200116225225.GA12892@roeck-us.net>
References: <20200116141800.9828-1-linux@roeck-us.net>
 <576b5576-3bd5-484b-ee3f-6198f9d87db3@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576b5576-3bd5-484b-ee3f-6198f9d87db3@gmx.at>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 11:46:47PM +0100, Bernhard Gebetsberger wrote:
> Tested-by: Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>
> 
> Patches applied cleanly on top of 5.5-rc6, no issues using a Ryzen 3 2200G:
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:         1.29 V 
> Vsoc:          1.12 V 
> Tdie:         +28.2°C  (high = +70.0°C)
> Tctl:         +28.2°C 
> Icore:        23.90 A 
> Isoc:          6.49 A
> 

Thanks!

Guenter
