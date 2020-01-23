Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D44FC35240
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A92218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 23:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3FX0UCz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730061AbgAWX0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 18:26:02 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42766 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgAWX0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 18:26:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id s64so11118pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 15:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4W28UQlErbB5t4AS0heTRzpi/rx98hbqyEgzItkWb6g=;
        b=n3FX0UCzVuXqvvCwf+bLdSICmWk2pxQ7chxMCCTB2hx42/dMimta3BQBEfPyQ2046Q
         Qm8+4esUf31iOSr2kHqW/yFshxkl6gygYlpIVbuXOuumGNu+lDpV6HJ+RER5kBAfDmeQ
         vdmU0syrs6DKDNGGupYB6Fwm/0fUnmeGHc9jpzbo2z5Kumed7XqkxXhITJCtDdzyuMIw
         M0OkibI6uMSi5pIQA9DNluRUY1L9QR6rU40wEQg+oH0EWcB5NwLDSwBoNCjvMh5eSlAG
         GLTytxkX/JFyIvPaa8kaCTqqErVUeJrwj2pxPOsDcIz1hCcoydlB8k/kM8mD0Riz/RKU
         VG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4W28UQlErbB5t4AS0heTRzpi/rx98hbqyEgzItkWb6g=;
        b=V7Sp4dGLrvl6g5bnPCb4lb+N9dA3CcHuqh9j2NWomOrd7i+WPIN0FZ1RZ70H5Ga+oE
         oJiKXAxurGBgRJFQxi8anQ8JFpJ9isiKgpVCy7absXc150qVlQvAHCr5Ce3Iv0jyOkLG
         zMe9dhTnbj5E9KpCLBf+X4U+ZDbmC8wH6a3sdxQTqF4uHgYym8pzZHvHtgTyhHOt4gvR
         LlVUDWugpqIjDpsaI/irMXpnNGMtcM5Z5bGQ5kJpXlvz9A/3rfGV9pxzJNzogeEalPzc
         M7/u6SH4+NMirpZ/dBJky3uhU4MPtSCuHszLvikGcz9y6Y7x55EHrZugznNU104pTu8x
         FyeQ==
X-Gm-Message-State: APjAAAWTlgfgPr9mFn1yMFLi35cR8gyAFMJFWXNaHPBXq8FlA+tcmPAC
        uODc0j/iNyn4RJwYbqJhEs6khutKe2BeA4gJJ4wU8g==
X-Google-Smtp-Source: APXvYqymJno0peJ1TM4oS2RkGgGa2NGhPBBBghYsDeQjjbvRNEzA7mcsVhxszbxtw7GarqhCGy3ao9ADKGGhHyUFWlI=
X-Received: by 2002:a63:480f:: with SMTP id v15mr820061pga.201.1579821961011;
 Thu, 23 Jan 2020 15:26:01 -0800 (PST)
MIME-Version: 1.0
References: <20191210212108.222514-1-brendanhiggins@google.com>
 <CAMuHMdVyjjZAoO3Q-Vr88fUGFwrn4EoiSxBmG_FV+o87BuBmwQ@mail.gmail.com>
 <CAFLxGvzMf1Fni4va1EM1ta_o7zDjkM8iAr=j+t74+G79wq=XOA@mail.gmail.com> <c80a1c56a5a543d2a7174e598919164aSN6PR10MB3039E2FB633AC95CF4279B04E2320@SN6PR10MB3039.namprd10.prod.outlook.com>
In-Reply-To: <c80a1c56a5a543d2a7174e598919164aSN6PR10MB3039E2FB633AC95CF4279B04E2320@SN6PR10MB3039.namprd10.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 23 Jan 2020 15:25:49 -0800
Message-ID: <CAFd5g45oZrj4MRQzJhujr1pVbOjjcqukAxm3NWTRPwO78UaidA@mail.gmail.com>
Subject: Re: [PATCH v1] uml: make CONFIG_STATIC_LINK actually static
To:     James McMechan <james_mcmechan@hotmail.com>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 4:30 PM James McMechan
<james_mcmechan@hotmail.com> wrote:
>
> Resent for the mailing list since my webmail decided to try to send html...
>
> I agree that at least the UML_NET_VECTOR is not compatible with static linking at the moment,
> but I was running a statically linked UML with PCAP back in December.
> I was having no problems, but I don't remember if I was using PCAP itself...

I was just going off of what Anton and Johannes said in regard to
PCAP; it seems to have deviated from the libpcap library, so I have
been unable to test it:

http://lists.infradead.org/pipermail/linux-um/2019-December/002548.html

Anton, do you have the fix for PCAP out yet?

> I seem to remember a minor patch I did to fix a symbol conflict but nothing of note.
> I have not played around with UML_NET_VECTOR since I run the normal networking.
> And I did not find any config info with a quick googling the vector version so I just ignored it.

Nevertheless, VDE still causes the linker to complain.

Cheers
