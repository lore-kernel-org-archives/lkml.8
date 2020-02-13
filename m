Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F9DC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AED520873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="w1uRGrof"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgBMFmR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:42:17 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40904 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgBMFmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:42:16 -0500
Received: by mail-wr1-f66.google.com with SMTP id t3so5095267wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 21:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrVdZxUS3EdrVwf2LulQeNvZSOGZj8UErtKTW8hDsp4=;
        b=w1uRGrofq8Crx4GZdwfV4wkquRC4twWMACVsFhy2Vd8PPoWrSLPsxcRraKzCuVKIas
         Yg8oy6NL12nIc2ofcDMw5Tajqly5YvuLoiTrfpyyGDjxQPqciZAWZfOsY7hNhULFrF6L
         K4fsc3JRjcrporH+RWc5Q/v4uWanuptrZUE2GDS9EZlDKH3N0XZmdHtexNAwuKl2vtXm
         npgUYKosKJR+H4OijQ/5Yrn5Uo2wtxngqiaxUjSL+WiGbkltgks4pFgKLX2UEeQHwgvJ
         H35ywMcxhefmRoAbu3nSPcAQcbfd6CZgIDR6yj6SV0FARWPbdYa3bz9XBLfLsZi3+Gfd
         FIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrVdZxUS3EdrVwf2LulQeNvZSOGZj8UErtKTW8hDsp4=;
        b=LdIawkhT9Rd5OlkglrDB8IYAgZOQG3SQuPCqSbY08Ace36Z3sMDVhaW7vbSSvoT5X8
         G2WEpgpmyjPwdXRKQtml/ZapVIOpr49337Y6lhf7fsMtDspukHcvJXbmFJkBEJMJi39P
         9bPts973o05r/2JSB6s76tfjfoCnisquFGvlN6azyFgeDw9Y5C363MwmPAbbO0NDbCRa
         +2aOWNQZcFTfE3aYkqn1dHKdceQ5v4DwROpweFZ8FG7Jq8yygMT8MuAxESHc28LkaSWD
         Xs6Jd9GDEZcOpvN678JuF+E6nu73IIB5iLFhk4ALPogsPfWKzzwB6nDPK7ECIWzNQbvd
         NLFQ==
X-Gm-Message-State: APjAAAVVT0Gskgp/hamVs2hiH5wC8jUkAr1unOmbgFzhyPDmHZs1+iDX
        WIWFJKqSQysFqrkzNtpAY2RAOffrQk60264MYC6tDw==
X-Google-Smtp-Source: APXvYqzbLibnTsVhaOasUfqj4QQmDz+9rvU/9cSEEzpgU+tO3apNBRAozS/osrvVGr+j/63o9K7WjhWWHKgRCSrzUj0=
X-Received: by 2002:adf:ea85:: with SMTP id s5mr19169000wrm.75.1581572533390;
 Wed, 12 Feb 2020 21:42:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1581555616.git.ashish.kalra@amd.com> <a22c5b534fa035b23e549669fd5ac617b6031158.1581555616.git.ashish.kalra@amd.com>
In-Reply-To: <a22c5b534fa035b23e549669fd5ac617b6031158.1581555616.git.ashish.kalra@amd.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Wed, 12 Feb 2020 21:42:02 -0800
Message-ID: <CALCETrX6Oo00NXn2QfR=eOKD9wvWiov_=WBRwb7V266=hJ2Duw@mail.gmail.com>
Subject: Re: [PATCH 10/12] mm: x86: Invoke hypercall when page encryption
 status is changed
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Radim Krcmar <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        David Rientjes <rientjes@google.com>, X86 ML <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 5:18 PM Ashish Kalra <Ashish.Kalra@amd.com> wrote:
>
> From: Brijesh Singh <brijesh.singh@amd.com>
>
> Invoke a hypercall when a memory region is changed from encrypted ->
> decrypted and vice versa. Hypervisor need to know the page encryption
> status during the guest migration.

What happens if the guest memory status doesn't match what the
hypervisor thinks it is?  What happens if the guest gets migrated
between the hypercall and the associated flushes?
