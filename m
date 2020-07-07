Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0D52067D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 23:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UStH1tT7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgGGXot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 19:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727945AbgGGXot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 19:44:49 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011DDC061755;
        Tue,  7 Jul 2020 16:44:49 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id a11so29315635ilk.0;
        Tue, 07 Jul 2020 16:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=any76awIeW3xlZvb4nwSImkAjsux+Sq2tCYpwBJX9BI=;
        b=UStH1tT7hvP7+piQ+yHe/AKxPI/qHV3oEDpUVwWNf3ToDXgdDhHCtf5bt7DNb444zn
         G6PVJLM6e7k35DJpy7agidx6CelZVtbwSh67CcQTPVXmJ4q3m2ry1cDlU8lpX5rWVHAh
         8gT8635sHVAAROIuNmQ9IhZgrt/sYZBY6JGs423PBOqDjaXMCbHvfF89EwodZ+olWdHK
         vgmG8VN0oDCJH+s9aM281iwAsILE13ZtEDBEBcdJ7vqzIyyBmFFDJmHoGe4qVXPNgR7g
         D42dfV5cQsqQevyEUZ1ji+0h+PbpqvB8Z+T1Bql4Gh98hWO7L6kL76lDdWyJI4yy4Egm
         7QsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=any76awIeW3xlZvb4nwSImkAjsux+Sq2tCYpwBJX9BI=;
        b=Q7jxjX+xfKR4mKBz3z8tZLRIs62lbTOwkWbLB+IezX4zqxYzQAdIMYkb4DdeKaoAb4
         XvN7DpEf9X/rkgqKXa6Rzw3SYqXmB1hF3C+6QDmt9UeI5KgvwslqSFfIaLkake9APXM6
         LAbK3w4glfMzl8vUyr0iZEqmyOUF4btEGXY38HtFox98FA5qU1nrEFbIhgAxSt0eVris
         DgXdwyhXNskt4bBIRiLDuXXapmFrMvB4RMY6+rEkkefIbjVm9ODgf+VqMGK28bqrZMIN
         vgQzAQdGLEMSZHiKF0CfKa69edD59VpBgJbhgMAcKkLA1sW4TGA112C2Lenbtchf0E/5
         c1AQ==
X-Gm-Message-State: AOAM5321fmTLdAmKasu7BQM/CzJcZTQxwkZFYV4D+EjZZy/RMC6ZaBp5
        OwIVbU29ONdiI2b9h2xzoq+dDC/T7ta4fjSWZBo=
X-Google-Smtp-Source: ABdhPJwEjktwNVlPsmXvdpqovQ3yOZTuUIAXof4OW/HwZCafqEi9TLsvQi09qf6HOEaEH3w9CryVlA2QHCQbYrktRns=
X-Received: by 2002:a05:6e02:cc4:: with SMTP id c4mr38956956ilj.69.1594165488124;
 Tue, 07 Jul 2020 16:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200616155613.121242-1-daniele.alessandrelli@linux.intel.com>
 <CABb+yY0eUG=bxrQHP9-5gHk7SYF=c+EE+0LGKhnpxgfr078n6w@mail.gmail.com> <08b2713a6f87f78746c22e7168f4813eb753bb0e.camel@linux.intel.com>
In-Reply-To: <08b2713a6f87f78746c22e7168f4813eb753bb0e.camel@linux.intel.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 7 Jul 2020 18:44:37 -0500
Message-ID: <CABb+yY1_BjyL=oeYq_P++SjNnECq=nfP-CX5dENLB5oLkNjVxQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add initial Keem Bay SoC / Board support
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Paul Murphy <paul.j.murphy@intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 4:18 PM Daniele Alessandrelli
<daniele.alessandrelli@linux.intel.com> wrote:

> Just one question: should I remove the mailbox and scmi nodes from the
> soc DT or can I keep them there even if the mailbox driver is not
> available yet?
>
A device node can not be merged before its dt-bindings are.
