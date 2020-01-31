Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B9FC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B77AB20705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jrkCIayf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgAaDRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:17:44 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41577 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgAaDRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:17:44 -0500
Received: by mail-ed1-f67.google.com with SMTP id c26so6209586eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oIg4izJ3dY0xBGHn3X1cuTzljmHGk0vFwMx8ad4w19E=;
        b=jrkCIayfH2CK8HceNhz9wMOG52M88EbYtjRjCrEHVAtiKxCEmkyk/ZivE2K8qKvnOP
         HiKlStkoa44zoxtKztVQKgk2LAIEkXfl2sGUbZRd/rcz/up0Q6G7HLb8vsgcaxt9uOY9
         aYUflFB+ekOmAtRwng+VLIOSqXxa52B5DqgIqnb4MZOtYIgZfS6+iD1qDIBWDAl+GAAb
         lH0vns5J8GHXg/fYr7nOIVnhQBcdvD2p4tjjbbJcw1Ih+6RAdvgtGnOqrbSSgvqC422/
         X+egx8zvpsjnWhJQegjGuqgQlg06uBZaDaQ5Djy0/WnQzk9KMCQ0AV4FEDi967Pl8i++
         THiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oIg4izJ3dY0xBGHn3X1cuTzljmHGk0vFwMx8ad4w19E=;
        b=siD4Zh3NLQfG894P/1/SEE0l3WRb8bJ7xgQssyDc5QRXlmQiq+dhy785UDMixKK/QE
         pIjroQkttvaqm6DJbobYVGgMXmAsxWlxe37EbeJH8Mwhg6g/4XaXCt46bncURNEM5iMX
         tlOwJ54OHSSSVGThbSyjgRmTc6eR0vFlDoWHJmbZ9yhdTltyCT5uC2ttB7pzOsOvV3XG
         QieTFNFNVgO675Tc2TyCkyQabRC/eimOUqVP9oE+CEhucOzYlN3Tk/oO5IspF7URtK3z
         1am6PWlKjB7gLXrj4aQW+ujrCs757D0DWWDKXKaD/YHTL4khzw4OLmibQyT6xf+E6Z3s
         2bYQ==
X-Gm-Message-State: APjAAAVl4o+I4VD25F47b+mfAfo3IYc9sFevRi2UCAyU9em6t75yheIP
        i6p3n0ykxU5DP83uPtgZlY1PV3/E4NXUYR2vKCZG
X-Google-Smtp-Source: APXvYqzzdWfnLzyByQcFVGmQCzqJhEsT1dBRVturw9d61zDsL2ZmJkMBe/HXMeV5fccEH2eEGkyfWfY/Ux/vDgbn3ec=
X-Received: by 2002:a17:906:9352:: with SMTP id p18mr6813461ejw.95.1580440661314;
 Thu, 30 Jan 2020 19:17:41 -0800 (PST)
MIME-Version: 1.0
References: <cover.1577830902.git.rgb@redhat.com> <194bdc565d548a14e12357a7c1a594605b7fdf0f.1577830902.git.rgb@redhat.com>
In-Reply-To: <194bdc565d548a14e12357a7c1a594605b7fdf0f.1577830902.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 30 Jan 2020 22:17:30 -0500
Message-ID: <CAHC9VhT9T-UMnu6bWdd733XB6QaP+Sm3KWhdy828RN_FVWBMmw@mail.gmail.com>
Subject: Re: [PATCH ghak25 v2 1/9] netfilter: normalize x_table function declarations
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        Eric Paris <eparis@parisplace.org>, ebiederm@xmission.com,
        tgraf@infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 6, 2020 at 1:54 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> Git context diffs were being produced with unhelpful declaration types
> in the place of function names to help identify the funciton in which
                                                      ^^^^^^^^
                                                      function
> changes were made.
>
> Normalize x_table function declarations so that git context diff
> function labels work as expected.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  net/netfilter/x_tables.c | 43 ++++++++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 25 deletions(-)

Considering that this patch is a style change in code outside of
audit, and we want to merge this via the audit tree, I think it is
best if you drop the style changes from this patchset.  You can always
submit them later to the netfilter developers.

--
paul moore
www.paul-moore.com
