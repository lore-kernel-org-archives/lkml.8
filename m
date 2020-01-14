Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FCFC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011A8207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgANJWx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:22:53 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:42004 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:22:50 -0500
Received: from mail-pj1-f72.google.com ([209.85.216.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1irIPP-0006qn-ND
        for linux-kernel@vger.kernel.org; Tue, 14 Jan 2020 09:22:47 +0000
Received: by mail-pj1-f72.google.com with SMTP id gn11so8514621pjb.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jan 2020 01:22:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ZWAvW0Rz1fE7AgqGVyczDvEbs9mU6QRWoYteCf8IMgY=;
        b=ApMbS4Izoyx4Hk/FJ1dSCDxh0lrd7E/SkWrKNyuuSPAi0gJwnmbLKMdY2yhM+li0bl
         Bs2Va0lYkdq9ysYxQzYxFLIUt7rjw+XZsX1P6XKW4GCj4pKsewRF+r08Rzxdsk1xlM3m
         3kENukQoBDwj0o9hFh+7UvhlJqUnDggDaMTqGSipSfJiG63Z2i7+OL/KoiGmDC/79y58
         cj31S88x7b/tokt4S1/nI2AIxOcT/6UXcIMTj2kInsX+eAw3T6oAghFfz5SudYT6RNIQ
         l49KnHn1j+D6or99jUQJe3qA12AMQKFB8n9HL98Qqx7mOUNTqYVqchD2vsvEveTclqwp
         46jA==
X-Gm-Message-State: APjAAAUd+isC+K0nnHN79UoDPwOCUuRT53pzhgQPhMj8UYqkHG4oBPLV
        /1s37VgYfA8YPQ7ZUSBXl5eVAbEPjaagJp1Ut5S4i19pOk3HxR+Ud7quNL6sAmSwI8A/WW3AVZo
        9IzF5DY8P0tJNjFmLOo9ddNyXv6GoxgXxkUVu5AkJ4A==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr27325366pju.80.1578993766159;
        Tue, 14 Jan 2020 01:22:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/dfKdh6hyfCjf7/vtp3J9v7vz7wJtppmbIjvVArkf4ZL6hlcXyW/MQU84uBegDfMHDLn6Tg==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr27325337pju.80.1578993765891;
        Tue, 14 Jan 2020 01:22:45 -0800 (PST)
Received: from 2001-b011-380f-35a3-5d99-e277-e07f-4d26.dynamic-ip6.hinet.net (2001-b011-380f-35a3-5d99-e277-e07f-4d26.dynamic-ip6.hinet.net. [2001:b011:380f:35a3:5d99:e277:e07f:4d26])
        by smtp.gmail.com with ESMTPSA id a6sm15893776pgg.25.2020.01.14.01.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 01:22:45 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] r8152: Add MAC passthrough support to new device
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <1578990223.15925.0.camel@suse.com>
Date:   Tue, 14 Jan 2020 17:22:39 +0800
Cc:     David Miller <davem@davemloft.net>,
        Hayes Wang <hayeswang@realtek.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Prashant Malani <pmalani@chromium.org>,
        Grant Grundler <grundler@chromium.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        David Chen <david.chen7@dell.com>,
        "open list:USB NETWORKING DRIVERS" <linux-usb@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <A3D0DBA9-7014-48BF-8001-6F34EC2200B1@canonical.com>
References: <20200114044127.20085-1-kai.heng.feng@canonical.com>
 <1578990223.15925.0.camel@suse.com>
To:     Oliver Neukum <oneukum@suse.com>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 14, 2020, at 16:23, Oliver Neukum <oneukum@suse.com> wrote:
> 
> Am Dienstag, den 14.01.2020, 12:41 +0800 schrieb Kai-Heng Feng:
>> Device 0xa387 also supports MAC passthrough, therefore add it to the
>> whitelst.
> 
> Hi,
> 
> this list is getting longer and longer. Isn't there a way to do
> this generically? ACPI?

ACPI only provides the MAC address, to write the MAC to r8152 it still requires hardware support.
So we need to use whitelist here, not all r8152 support this feature.

Kai-Heng

> 
> 	Regards
> 		Oliver
> 

