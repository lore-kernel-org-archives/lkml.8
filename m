Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E40EC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67964215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UUzhm7q1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgBQQfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:35:45 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44265 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgBQQfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:35:45 -0500
Received: by mail-wr1-f66.google.com with SMTP id m16so20479999wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52jPAcnAoB9nyjNBUO8yybzpzXsdhabpDRivx/vqyIc=;
        b=UUzhm7q1EVvdF1Pd6XLhsq/6MA/y1xrp8bBCv3aUs70L/SB+mVD+PPnxZxSYvQ90JB
         habZdDrMlFUGlPZEspdHoOl1FN3HNbEa9eaXIk3OTxLHS7zBWOezzdlrQMPnpVfG53GP
         6lpVCKlpBLuULKoT4lipuGr5cJ13bXi/W7sKxGmo0OlElT6DlPV0i1ogCy3ogJfj9n+Y
         q+lNWpLjWG9TFE+IQGWUlARMjMjmXJMalkhlb9l1VtOIqPjkd08t15nc/Da5fehNM1as
         ugGJrsLTzwklZlJDxJkoyDp5+PxlQNRq8CGt1JXZQZIjvepFR9S93/sJ8e8pH14kqKAX
         vgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52jPAcnAoB9nyjNBUO8yybzpzXsdhabpDRivx/vqyIc=;
        b=Z3fZyt38wp8t6kzxgU2VX+N9hkGsLKqC8JNM0cYkNnkEHTtNglE/06WOAAt8owTCIN
         SFmNSFgA6lJ4vtWcY3/10PE/au+HqY+8L3bbjTBmfsi/8NeMmVSrt9GYFzBGfYh/xKZ+
         rDC7P1PHusGh6HrmTXlGbB2zO0t0sBJtyisTMBYrxiQffEFCXc5IvAcMIT5eYE6tnxK5
         9qKlFvKVkOnhL0K7TwNpQZheb6yfjDlovi6HPXne6fkGJHI/29BVx/YkMo3hHlgn8xRQ
         fX+GxPf43HiGx6yHmSmvI6OUsB/eVmPG3jc68caR1lL177tsT1DSyyrr2DLGfRp+GaYf
         QZoA==
X-Gm-Message-State: APjAAAUdTDSqYq5aT8AyW5XgcXPgFrmdfRYab6JTWRM3Ejbsp6i8FGx4
        cG7tnLTMoIPhhsVne3Z/q5QkNg==
X-Google-Smtp-Source: APXvYqwANjyM01+uFceFTRuN/F5AwPa51jyHgN/NDw+AGq5VKaoIAKf9kFJD3a2KrUDWQZ8Lx3dckA==
X-Received: by 2002:a5d:4d0a:: with SMTP id z10mr22888113wrt.253.1581957341244;
        Mon, 17 Feb 2020 08:35:41 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
        by smtp.gmail.com with ESMTPSA id r6sm1633466wrp.95.2020.02.17.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 08:35:40 -0800 (PST)
Date:   Mon, 17 Feb 2020 16:35:40 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Quentin Perret <qperret@google.com>, masahiroy@kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com, jeyu@kernel.org, hch@infradead.org
Subject: Re: [PATCH v4 1/3] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
Message-ID: <20200217163540.GD48466@google.com>
References: <20200212202140.138092-1-qperret@google.com>
 <20200212202140.138092-2-qperret@google.com>
 <20200217152201.GA48466@google.com>
 <20200217153023.GA71210@google.com>
 <nycvar.YSQ.7.76.2002171059230.1559@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2002171059230.1559@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 11:00:39AM -0500, Nicolas Pitre wrote:
>On Mon, 17 Feb 2020, Quentin Perret wrote:
>
>> On Monday 17 Feb 2020 at 15:22:01 (+0000), Matthias Maennich wrote:
>> > In case the whitelist file can't be found, the error message is
>> >
>> >  cat: path/to/file: file not found
>> >
>> > I wonder whether we can make this error message a bit more specific by
>> > telling the user that the KSYMS_WHITELIST is missing.
>>
>> +1, that'd be really useful. I'll check the file existence in v5 (in a
>> POSIX-compliant way, I promise).
>
>In fact, if you explicitly provide a file that is not there, then this
>is arguably a good reason to even fail the build.

I agree, I would expect the build to fail in that case.

Cheers,
Matthias

>
>
>Nicolas
