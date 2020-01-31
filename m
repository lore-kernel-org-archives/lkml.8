Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F92C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE91206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuHcr9bF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgAaRJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 12:09:08 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43516 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgAaRJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 12:09:07 -0500
Received: by mail-yw1-f65.google.com with SMTP id f204so4359675ywc.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 09:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TWSU5DCjy0FzPulQ5vCJe9Q7q9veeI/AGIoH1Pgxbn0=;
        b=iuHcr9bFTbYJ1OzjvgnqOIqK6hAjjFf9JnKaser/TUpmYTmmjOs4RiEgVX6o55lpYu
         6ziBiSZE9Lwe6Ibm4XdixDbzLbXArXv4gdvYAzmqz4EWry289a3PVrdS8ZD22Y1FITQd
         C1taauCF8Yy59yFD0+X5zIKWlx2gkPH6dPbNHTl292pD++MsB+M4XQGZNvdtUL5ZYTAK
         8NtoiHSPa/AAPau5Rf0cJL8AaiCsGWT7fPXnLxXl87IfHd8Xknz2OdU5kjKittnvONV2
         bnrT3OO0yr5naiRBVXxP1H4/SJb6CKd2GlHtc9cN7lV3qp7Qnhg92smQHD+Se3aL/bNx
         SxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TWSU5DCjy0FzPulQ5vCJe9Q7q9veeI/AGIoH1Pgxbn0=;
        b=oQefKGA+GW6sGTEeB9zFzqYUFdSpKp3vN3IrIrwF/FA0wNLBY/G0kGIVGAQ82kz6zC
         FIpCMYabraxWSlcJlmYnIERW473LwKuYV2oI1rqrarNtPNWoHZs+L752DiM9MAhT5gaN
         Nczc3Zvn7T1xyCMu4tIFwU8N3uQL6d+xostK1suF3vl382/FoSMWopiAOlusrwhKc8pS
         PdPsMa0q3tprD8gNGJhaK1yoqGvdpS4Ve2aGMTkKJf0/aazJRFoltD+gvMv9utDdid1q
         N0xzCVezbNn9U1qT9uB0mpQmhEpT85GHS2sYpARwie/BzdCRSO45XpPo6q9KQ7wHnC+l
         0dOQ==
X-Gm-Message-State: APjAAAUcO+i0lkvxMT6mIphb/2tTrWiQWkz1idwGNLiopHxs6dLcLxtb
        XlkPSGAgi/XjfkjzW5xM7Wuo595GiBa91Aj6VPaw0RFo
X-Google-Smtp-Source: APXvYqzbvttA/MTUE16UgjkuFNSqYUYXrB/W7pmeUElKGGNw3odxPmA+9odWuJJgHy7OOkYO9yT6+lv+4eaI2NIwh+0=
X-Received: by 2002:a25:cfd8:: with SMTP id f207mr665984ybg.408.1580490544982;
 Fri, 31 Jan 2020 09:09:04 -0800 (PST)
MIME-Version: 1.0
References: <CANn89iJjZdoTKnnHNAByp7euDWo0aW9bL8ngw78vx4z7pwBJiw@mail.gmail.com>
 <20200131170508.21323-1-sjpark@amazon.com>
In-Reply-To: <20200131170508.21323-1-sjpark@amazon.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jan 2020 09:08:53 -0800
Message-ID: <CANn89iLr2iXjcRjmVpsGAtPFvya948pXHUBzK3=j078P3bQuZg@mail.gmail.com>
Subject: Re: Re: Re: [PATCH 2/3] tcp: Reduce SYN resend delay if a suspicous
 ACK is received
To:     sjpark@amazon.com
Cc:     David Miller <davem@davemloft.net>, Shuah Khan <shuah@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, sj38.park@gmail.com,
        aams@amazon.com, SeongJae Park <sjpark@amazon.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 9:05 AM <sjpark@amazon.com> wrote:
> Oh, then I will use 'tcsk->icsk_retransmits' instead of 'tp->total_retrans', in
> next spin.  May I also ask you to Cc me for your 'tp->total_retrans' fix patch?
>

Sure, but I usually send my patches to netdev@

Please subscribe to the list if you want to get a copy of all TCP
patches in the future.
