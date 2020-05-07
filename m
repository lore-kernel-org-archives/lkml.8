Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B060EC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FA262075A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="XeHQ3OiH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgEGDiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725869AbgEGDiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:38:24 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6145DC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 20:38:24 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id j16so3908485oih.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 20:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d0cQq4xYVzYPxzyVLbBLMpWehBwGYgPxNzAF85GiSfE=;
        b=XeHQ3OiHkwJ8xT3Ya6XM1SJOsqPv23Pjveh468DQabZ5fp+bykhAi+ZmC9PoKgG9CR
         Yl+3Xi4b7WQmgDPI9noIy777DxVwgGgP0oSxGHoi0woUcd8iXj2H5VI81C6dabWmD0P/
         h+RagNwXqFR8VAmWPzqHmvaxrlpfClz72fKiuqpA0dtAiodikqRvbvzpKL94i/ZK9Hwu
         nqvWexmvmy1bw8u7K7urw4H1igbO1rcqoPDZIBRJywqRqsj1ClwMPhjHcAUnNrhkTYTv
         QCiwQQOzslL7v0wqJpLIihMWVNlKRrjyZMG6ASI8Cpd9AxqdHIQloHNHkXww8JL0OUeL
         uBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d0cQq4xYVzYPxzyVLbBLMpWehBwGYgPxNzAF85GiSfE=;
        b=Rrizx126+HLRyOFGnDxmiK7cIDTGCLCYlCswjAKDH6nMVijGeXDA6SJe2NQCXlQBXQ
         YxyANLulDD5F3ll1jW99oxqI3MWeDMKy0WlBeaJDeSgl/+OuGmKdilFK9Hq06a8aTI3+
         exT75OcDeXkpt4Q52qizd/C3glfmwEa66oS6RKPxGBEOK2NkYpj4znE0jg3arweKNq1e
         01Phi7aItqBSpgFFFUU1Jet6Vfbl4+kMl9lCEOV/8Fo6q+uPFUk7gCO7pjz57P6QuXRY
         ueetRwj9zCY0j6A4fV0Z7LAfZC0HPXHsLZCBVnZra+8PIjjmfw+SpRb+R6W2/1EQ27xE
         Ek5w==
X-Gm-Message-State: AGi0Pubf9D8OFkmXRwp3kxZkCh9haG43epmScctpRQuwXMtGqFWqYviK
        Ba8DgV6ItuJCSxHRqb1hj8U6QullIURW1GzpAM6hZA==
X-Google-Smtp-Source: APiQypKeoTq4Fn0g+OFMHCi+moiq/xR/F6cwta6TxxrGshqaggMLYBBmp/8fE4jGyVDn1L0+Qub8g2v2+ELApD1EDO0=
X-Received: by 2002:aca:447:: with SMTP id 68mr4938547oie.94.1588822702710;
 Wed, 06 May 2020 20:38:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <CAJZ5v0gZH61ui04Howzif-_Xc3-X9GyAx7FgZ=ZS2X=4KotEng@mail.gmail.com> <CAJZ5v0gX1gx1_zTZg=M+xEOqxPEaq8ZU-N3hwk7OGcGdzrdBTg@mail.gmail.com>
In-Reply-To: <CAJZ5v0gX1gx1_zTZg=M+xEOqxPEaq8ZU-N3hwk7OGcGdzrdBTg@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Thu, 7 May 2020 11:38:11 +0800
Message-ID: <CAB4CAweZcN0SPe-a7jbthV=-ip9cCzJOM=NfP9YvtXw97ugKgQ@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 6:19 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, May 6, 2020 at 11:32 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> >
> > Thanks for the report, the issue evidently is EC-related.
> >
> > > @@ -1024,7 +1024,7 @@ static bool acpi_s2idle_wake(void)
> > >                  * regarded as a spurious one.
> > >                  */
> > >                 if (!acpi_ec_dispatch_gpe())
> > > -                       return false;
> > > +                       return true;
> >
> > Have you tried commenting out simply removing the if () check and the
> > following return statement?
>
> Scratch that.
>
> Instead, please try doing
>
> acpi_ec_dispatch_gpe()
>
> instead of the if () and the following return statement.

Yes. I verified with the modification you suggested on my laptop. It's
working OK.
I can wake from a keystroke w/o problem.

@ -1024,8 +1024,7 @@ static bool acpi_s2idle_wake(void)
                 * If the EC GPE status bit has not been set, the wakeup is
                 * regarded as a spurious one.
                 */
-               if (!acpi_ec_dispatch_gpe())
-                       return false;
+               acpi_ec_dispatch_gpe();

                /*
                 * Cancel the wakeup and process all pending events in case
