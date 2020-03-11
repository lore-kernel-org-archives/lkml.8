Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C673AC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF1A52074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdQ1WL15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbgCKWxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:53:22 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45101 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729739AbgCKWxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:53:21 -0400
Received: by mail-pl1-f193.google.com with SMTP id b22so1792769pls.12
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nl0EJrzWK+YJkV8HhMmcT9tiOsgoC3rUQBwiJfZfbmI=;
        b=mdQ1WL15H3HpBJQ9ftHgqBMXwEFISYk/sfK7fTi55FQDh0twBW0uzYAS0nZYOlg8qr
         T8RTLWDqnQRX7az06J/CUvqrN72icBlh7vISkIA6yvh7gbaCNrJNFJ85uTk/nBRXRuJh
         ULJtP4OSouiHhUgQHSOw6Un5Z9ZYk16lYG/qKyfhAWV0w5hS5BZKJBB9l8Oh6oKlJrFR
         aaUW/b+2TyZzHxXjScPQMAUcO6Msn1ujiKadmARBeakdC4Kb1OYEkkkM4AVM0VmsuwrW
         D+oluHn4qBKYjXvYCXjvTIfujJ+5146lCDk1HoDYNOxBFkJv4U2UNHEPTXzgVE0jjpRy
         +swA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nl0EJrzWK+YJkV8HhMmcT9tiOsgoC3rUQBwiJfZfbmI=;
        b=Uq4eKr5N+/gtHuQrgbFZd9leIc9cDwX8cRE+I3v9lTPVQkGKvKtpgAvTj78llSyyuz
         RTfTjVFcrdLrw+8TN8P7GAwFJ7s4IkXjy0Ue9rPD4TmtS8Bm92uac/w0OpuU+XVUK5k5
         c9ymtLsDlPyiwGDTrFVfBK09uIPidcSMD6o03asouJxAqMyFqIZiM44Dhoge4BRtzpTL
         HO0nH+JHYpPsuQ+qIxpKTMTqsORq31tr2+pgNOwtNojrsGMxUtuczfUi2/zruGkF1sij
         qhE8eeimklAMyC62AR2ylDZtWUfTAY0hpqrC9ezNC8LtPAHtspyWLmLxnENTD6gJUV9l
         PolA==
X-Gm-Message-State: ANhLgQ3o1f57nM4LICBEOWJ0tW3Ciz5LdfWq5fDFWIBhLKulrZq4UW+s
        mJ1OdhuP5Z4bJp1TKSmmKa8LyxJI2ArvahypxkbEDA==
X-Google-Smtp-Source: ADFU+vvagulKuellazVhh3XheT3knudCK7WIBbsqd7EZUzfcfz1tEE8u7grMDhDQ+9mv3x9w1tIN7Tt6p+akUMEdLoA=
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr5209789plt.232.1583967200859;
 Wed, 11 Mar 2020 15:53:20 -0700 (PDT)
MIME-Version: 1.0
References: <1583320036-442-1-git-send-email-alan.maguire@oracle.com> <1583320036-442-4-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1583320036-442-4-git-send-email-alan.maguire@oracle.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 Mar 2020 15:53:09 -0700
Message-ID: <CAFd5g45nFs2zoD2gCq6oQ-orDxe3VbK1FqCpoM9BL6-eHxsJaw@mail.gmail.com>
Subject: Re: [PATCH v6 kunit-next 3/4] kunit: subtests should be indented 4
 spaces according to TAP
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 3:07 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> Introduce KUNIT_INDENT macro which corresponds to 4-space indentation,
> and use it to modify indentation from tab to 4 spaces.
>
> Suggested-by: Frank Rowand <frowand.list@gmail.com>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

Sorry for the late comment.

This change looks good except for one thing: kunit_tool
(tools/testing/kunit/kunit.py) expects the wrong indentation. Can you
fix it? I think it would be best to fix it in this change so that
there is point at which it is broken.

Currently, this change breaks it. For example, with
CONFIG_KUNIT_TEST=y and CONFIG_KUNIT_EXAMPLE_TEST=y. kunit_tool
reports the following:

Testing complete. 0 tests run. 0 failed. 0 crashed.

I am pretty sure the change needs to happen in
tools/testing/kunit/kunit_parser.py.

Cheers
