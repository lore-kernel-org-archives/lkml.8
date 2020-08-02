Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D6CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94B92075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFIyCvpC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHBJLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 05:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgHBJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 05:11:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8F5C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 Aug 2020 02:11:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 9so11790164wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Aug 2020 02:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=GOI1c5bl4yi1L6tURgqekpW0DbIMIRV5G+t5vtGHdE0=;
        b=hFIyCvpCtd1mxT/D4FkEIfIU6U3xn8HiZP7ovOg54nSjLKPMh5L2rJTUCyXIfJsMG+
         YBtR9K9UDXgVlDIeVa3YDJ81GcPsEX8xlXOQoslRJW/1SuGDiADF8qqK41CHFjwtlKMf
         OQ88aAklXFuY8+xifkUjPfhvw//yWVDy1jO2ETxTpU/tJC9W6NneGFSl6M8zbFYhcugQ
         nZY/MggPKuch/IBGdLNjt8H7B570si91RiZdo9NVjWJRXVuqUIE28sKC8u42eBUfWnQe
         Rp+q/hJ9LVVrLM2Rrnh87twqtYsivrqdqF6bHV7Kz2qfKuMSqL8uJxFsUtvWWBceP2SF
         u3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=GOI1c5bl4yi1L6tURgqekpW0DbIMIRV5G+t5vtGHdE0=;
        b=VXFi+ZpnRNtT07FQ7EGgOPxJ+6FcSsMHzxXb3djrQovhbkr1gXDS3eLAROZtprMFHl
         lpQbY9rdm9f32iiVlReaFzFiKcldK2PXn5v9x3NkcHnp/UUby6GkQ6N7nD6GZ3xsLrU1
         dzeeLpOwlb0G4MhHAwtWnXD9FlRyQOsbPqfWPXlUZZgGbStJ8kHA8lR1RvAJ6F4G+Elf
         HVH+Zyq6znVs+SgQLLVSC+aJi9UtzRj+UqLeZVzJr1We/gOeq2n0J35wTC4AKNmPMrdd
         p0PfFgGC7+TNDy6PUlTHNj/m53f7zqgQzSEZURcnzAE3QS5G6yaiD5f9wqF7gWhWNMrE
         oRVA==
X-Gm-Message-State: AOAM531oM62RliGGn4dESQSrjuFyYVFhIfjRjNo2ZNYrAjNcZxNpcnhu
        tah4YZt5pDLgVZoFKI+nASLvPE0I
X-Google-Smtp-Source: ABdhPJy0IaCw5tudXdRthaPZfo+L1dWA0JwCjDufgvThz+kikOQNka7zpENwXOeM6eepFTXqPo032Q==
X-Received: by 2002:a1c:7702:: with SMTP id t2mr5320261wmi.169.1596359465836;
        Sun, 02 Aug 2020 02:11:05 -0700 (PDT)
Received: from [192.168.178.22] (dslb-002-204-142-085.002.204.pools.vodafone-ip.de. [2.204.142.85])
        by smtp.gmail.com with ESMTPSA id 126sm260904wme.42.2020.08.02.02.11.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Aug 2020 02:11:05 -0700 (PDT)
To:     gregkh@linuxfoundation.org
Cc:     christian.gromm@microchip.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
From:   Michael Straube <straube.linux@gmail.com>
Subject: staging: most: Build error since commit "drivers: most: add USB
 adapter driver"
Message-ID: <7c18e466-0941-ee7e-9a0f-5a993c993152@gmail.com>
Date:   Sun, 2 Aug 2020 11:08:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

with commit 97a6f772f36b7f52bcfa56a581bbd2470cffe23d ("drivers: most: add USB adapter driver")
I get build errors.

$ LANG=C make clean drivers/staging/rtl8188eu/
scripts/Makefile.clean:15: drivers/staging/most/usb/Makefile: No such file or directory
make[5]: *** No rule to make target 'drivers/staging/most/usb/Makefile'.  Stop.
make[4]: *** [scripts/Makefile.clean:66: drivers/staging/most/usb] Error 2
make[3]: *** [scripts/Makefile.clean:66: drivers/staging/most] Error 2
make[2]: *** [scripts/Makefile.clean:66: drivers/staging] Error 2
make[1]: *** [Makefile:1763: _clean_drivers] Error 2
make: *** [Makefile:336: __build_one_by_one] Error 2

Did you forgot to remove the below line from drivers/staging/most/Makefile ?

obj-$(CONFIG_MOST_USB)	+= usb/


Regards,
Michael
