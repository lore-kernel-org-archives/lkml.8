Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA8FC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ED232073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DipvBbqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388313AbgCCSHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:07:03 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:34845 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbgCCSHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:07:01 -0500
Received: by mail-wm1-f45.google.com with SMTP id m3so3872654wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 10:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XXp0rMiFWFLtHxX3NcGz0E4EadvUHGoaT5BnD3fzxj4=;
        b=DipvBbqTm7dhpHJLeJnyc7q64svimc/d9W3kAB2/UuEOX7G6sHtwLYdmkQk1cjw7eB
         srMt5Jne+vS8TZeVHLCsV2Cs2XDFG/M88aLs0SEu1F2aWowKXHKKBvVX+QbKaRJHvTMc
         QhWc6TEdcvxhAUix0NUbYAE8Ld/dqSCabMYs4pH7gzYYLKnosnQWpHHPNLoNIga+ky1z
         vf1IXvxwhGZmA2hjnSegbK8zg9UdoxmZmaF+BDfdD9gsRM0dfxkMkO3lNMzOxC/+mIWz
         K9qvj8u8W2KNICKgtBHm2M+x1SgE3+cNIB5yr4YPf3MnV7qRqVnlTusGDxpOdS0jqgoa
         4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XXp0rMiFWFLtHxX3NcGz0E4EadvUHGoaT5BnD3fzxj4=;
        b=IaMNJlPshDddS7DQCGMkq32t+NV1kiqHOgtyOOJB1tNrjD/pkSBZ37d3g7ApDMTiSv
         JZK7/auqXVVr1TU2QYZGXlr0Keq2XuUuLpOe76OFjeefb0lun5g8csP0vZhSYsjne6bj
         yOxmnRYxaXGJMCUJB+Mck0ORv8iFH+EnKh8krIsSK61z2TNM+eqJpb88Bmv6vlCCl+EM
         1cGhH+O58c6ryBmKI4u39k8bfCveSPI8bIkrI7ZdIAy9/F2yWU0vzEYQzrjmew+M4Fsi
         XPBjVG5ZqSXpXKUfI8pqKp2kWvk1Fr8r+IkrESOMx6/9GjqKUkVV9MQoL09GN4Zp2c/h
         175Q==
X-Gm-Message-State: ANhLgQ3NwitfgsNM6CFpMJgS5yKx5edsiE2C2p2NzmfFp9YPYUX9tOHL
        EVjXs0L3nS/9ZeYEQHFMSjDmXg==
X-Google-Smtp-Source: ADFU+vtqBLqRlqk4p5QAInZ9UVNhCa+KDn2TFoZRPh9x1StfHVRfILYXQHAGFmeGa8ccIO44I6xsHg==
X-Received: by 2002:a05:600c:118a:: with SMTP id i10mr5508685wmf.142.1583258819732;
        Tue, 03 Mar 2020 10:06:59 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id k65sm5476086wmf.1.2020.03.03.10.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 10:06:59 -0800 (PST)
Subject: Re: [PATCHv3 2/2] serial/sysrq: Add MAGIC_SYSRQ_SERIAL_SEQUENCE
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <20200302175135.269397-3-dima@arista.com>
 <202003031201.WdZ9GaGO%lkp@intel.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <58272ab2-a149-8b7a-d109-1d7b9564c167@arista.com>
Date:   Tue, 3 Mar 2020 18:06:53 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <202003031201.WdZ9GaGO%lkp@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/3/20 4:31 AM, kbuild test robot wrote:
> Hi Dmitry,
[..]

> New smatch warnings:
> drivers/tty/serial/serial_core.c:3123 uart_try_toggle_sysrq() warn: unsigned '++port->sysrq_seq' is never less than zero.

False-positive as just a few lines above:
:        if (ARRAY_SIZE(sysrq_toggle_seq) <= 1)
:			return false;

I hope it's fine just to ignore this rather than complicate anyhow code
to suppress the warning.

Thanks,
          Dmitry
