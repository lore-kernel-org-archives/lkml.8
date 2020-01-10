Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF004C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:30:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1BB320838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 21:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="dCEwU9oc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgAJV37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 16:29:59 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42909 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726909AbgAJV37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 16:29:59 -0500
Received: by mail-oi1-f193.google.com with SMTP id 18so3141480oin.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 13:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n2mxxlKQ3z5GTVr0sFZ/UO3UPo2+qy5+H2Pzt1Zkygo=;
        b=dCEwU9ocO7qaLRqzQSLmYs/X59vGdpavT680mPOTiWdjYqJpoXuFoEB85fEAbl/R3p
         /y3AKOYu3spzlXqH/C61jCHa9TIHmuFBmGDnoA5qtqUaZmeSgyxy3V1zTF0Elay4sM09
         u0Ul91Reo0p8yrhytuqg9BsiOFdgxiv50nTGAt9IOy3SYbLoOoyFhWgvWsZVN6lPg6VG
         IFp7ItvVS2lWbifAFtj5ruAuABfk1/GLKmZ7tTkhRQxlrzDPIJFrv8+QoU3gi4HLluQO
         0kns4yL3aTNMjHPY/3bhjJxF58/xBa22EVXeeDBGQUCDPEQCTpMi86FzgDz1gulGpc8E
         n5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n2mxxlKQ3z5GTVr0sFZ/UO3UPo2+qy5+H2Pzt1Zkygo=;
        b=IfywMdwc73qE8q1/oOuq/WCdiGfAZ4tb7dCnESIuEIpm9W3TN1m/JjzynS3pTm75Y8
         D8j8df0UC0E3GDmIfZf9h1CCya3S/CgaAkBu84k/7ZCUSuUNfaUKEhzU+zamyTF9ycBf
         C4d/0pdIdlsvi81AtccSkcymgMn0EF3ENL8mxyBv4QFrZlUg2SA6N2mT09YTz7R5/Su/
         JjKuJ1AHWj8kC6sI5TwGO/AleT1WkJwRHyxc1Dmxx6yIYSC8nr4X0n0m+GhSgcPOwNK/
         VxbYQBWb1JCcER+fU4UGIoyfvtdN8ppwZzNThH/V7Alsxk44zZDMatYvQ6q5RSFpFtfy
         u8gA==
X-Gm-Message-State: APjAAAWOBANjgsHWznxiJw2iKCzaeMG276eitoNpWnF0pyKJKAXoQrmJ
        JVpm+BUV5M9PrFPehxOmxlD80kyNqRaxaIquVydQpA==
X-Google-Smtp-Source: APXvYqwxQz8fxi8L1VftblbeLJlRU9OyUs7b4BgCeeRqP9aOQVdGF6FRWI3UMAhHXqhXuMwGJ1X7oILHYEfQbi0fDDE=
X-Received: by 2002:aca:3f54:: with SMTP id m81mr3657692oia.73.1578691798574;
 Fri, 10 Jan 2020 13:29:58 -0800 (PST)
MIME-Version: 1.0
References: <157868988882.2387473.11703138480034171351.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <157868988882.2387473.11703138480034171351.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 10 Jan 2020 13:29:47 -0800
Message-ID: <CAPcyv4j=rhEN6M-h=p=4GHYTj2vQEsG5kQVKKwaM6U1CHLOPyA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/memory_hotplug: Fix remove_memory() lockdep splat
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     stable <stable@vger.kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 1:16 PM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> Changes since v2 [1]:
> - Apologies I overlooked that I had local changes in my tree to fix a
>   compiler error (misspelled assert_held_device_hotplug()). Now fixed
>   up.
>
[..]
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 96ff76731e93..e042da3b1953 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1553,6 +1553,7 @@ static inline bool device_supports_offline(struct device *dev)
>  extern void lock_device_hotplug(void);
>  extern void unlock_device_hotplug(void);
>  extern int lock_device_hotplug_sysfs(void);
> +extern void assert_held_device_hotlpug(void);

Argh, did it again. I definitely need to fix stg mail to not send
patches while there are local changes pending in the tree.
