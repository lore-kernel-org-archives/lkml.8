Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCE5C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E602206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582423683;
	bh=Zuhqskd1lycUn/bebo2khW678eli9Ec4ckfj5Wqhwzc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=rGEzb1SJohym0yPq8BpKok+pr87tKBa7ZPG94DusbJvJbMaBsDc6eYsYUIVomHS+4
	 jx7uyl1oxSIeYK+l7Ifs5/TbaNju3r+uDV5UzYivAv4i6nDNzG3hFcNQZGuHfQHmjr
	 faGc0/breK8B51s14IlVOkMC+5mXAT5SgeIDQE0o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBWCIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:08:00 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43713 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726965AbgBWCH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:07:59 -0500
Received: by mail-lf1-f68.google.com with SMTP id s23so4281400lfs.10
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J4EpyKP0B16qUqyv0D0u0i1KANfiNDemnRfXEOMQZ8w=;
        b=D59j+IUyZoIzeC5uolMmJmJpCNfBDS5i850QEQva1gY5p/iyqk4L8l/OnaOXmzo8MV
         drvUkV5r7JXptxn8mU7gALV8/72ndjyNibKEkb702NJ78lZz9nygv9ROLBKItoBoM9+h
         BPt8ag3da2zcoarpcsJrURNdbl7jazzqgrIaY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J4EpyKP0B16qUqyv0D0u0i1KANfiNDemnRfXEOMQZ8w=;
        b=qyjgtfoTflQIGrodzEEPbomo3JIDhq6zIVsgvbf9EdBTMuGxMwZ995v5hVtG0ccQFh
         NhIj72/cmnLwMggCkJdglX1Psq+yqWQIbWQ8bnAinBes3iKbFo3S+p6o8rLuGajg9gTU
         5QOz6NFshTKiqJMofQxemzBxF0ZXMdmESY7Ux60zlYukve1sXDa7lT9w+jYH4sre5bJn
         DRBppabTgP5YtTmVV3MlenxdwVAIjSjrfP7XaHU8zH3gc3/QgWG2SzYxsDLTRjzBjydz
         NnPpz++Fjccvkm3qCIxLNbQtey9UKwfBqR/29Yff0zDJZ/L/X+EVcJE56wQzQB5W6C5u
         82GA==
X-Gm-Message-State: APjAAAVK+tc/W0KQi74FzULNDpf6mZxX90LcQvlZB43LoXCs/JTd0jEf
        lo05mDb/lj+EAZUc/r/hdP2Xb2tcbVM=
X-Google-Smtp-Source: APXvYqy+27yaWzkeSLXrN/2RhArFVQz6ppY2X5d1HTndrAZihCxl0uHr9D3duFsspLsQO2vdUt6/2Q==
X-Received: by 2002:a19:5013:: with SMTP id e19mr23641572lfb.8.1582423677586;
        Sat, 22 Feb 2020 18:07:57 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 138sm4020271lfk.9.2020.02.22.18.07.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2020 18:07:56 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id x7so6233411ljc.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2020 18:07:55 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr25338680ljg.209.1582423675207;
 Sat, 22 Feb 2020 18:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20200223011154.GY23230@ZenIV.linux.org.uk> <20200223011626.4103706-1-viro@ZenIV.linux.org.uk>
 <20200223011626.4103706-2-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200223011626.4103706-2-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Feb 2020 18:07:39 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
Message-ID: <CAHk-=wjE0ey=qg2-5+OHg4kVub4x3XLnatcZj5KfU03dd8kZ0A@mail.gmail.com>
Subject: Re: [RFC][PATCH v2 02/34] fix automount/automount race properly
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2020 at 5:16 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +
> +discard2:
> +       namespace_unlock();
> +discard1:
> +       inode_unlock(dentry->d_inode);
> +discard:
>         /* remove m from any expiration list it may be on */

Would you mind re-naming those labels?

I realize that the numbering may help show that the error handling is
done in the reverse order, but I bet that a nice name could so that
too.

              Linus
