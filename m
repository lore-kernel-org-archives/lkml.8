Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F57BC169F9
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCB5020801
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582139271;
	bh=K+l4PwzbcGcfT9N6LvjaNpSxXm+P598rAuw+Hp3l4js=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=BcviR8bS3EGMikSxxgC/uoWFAJanmn4vQREcJBH/Al8WZ8K2I+KU1DedpW41QP4M5
	 idgmDNcYjrA7nvygwUi4EBIrdJ+/0ZIGlpg2H3TcPuS2yaLnLQpevsJZs1Ifo5VVZ7
	 WGFZ94yP5nh9MEMgtCq7HHmbLEy8EA4JDReVsoVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBSTHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:07:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:41588 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgBSTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:07:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id m30so990156lfp.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PW7lNRLaUwWMkxjmDviGmCx98DZMFUxSA3+XY1xBUHc=;
        b=Hx1j/CCXthRsFcYUkCqUCZKHuALKrv53PhNO0/eSPdI55ETBuvMT4Bzt7Qa//aT+Xq
         pbz3LbAT0K7mf2O2wl4T+6nDRq33OiFGxtJRkEnoPAzmD/q8ILz+w8fB+i5OEbDM4aTv
         V5D7jcX/IJAfFXSwG3AgccJqFA6k9pBx+DkqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW7lNRLaUwWMkxjmDviGmCx98DZMFUxSA3+XY1xBUHc=;
        b=qSiz/2l/YCnGuYu23z0unUwTUO7wTh65z3tITUIqzJe2vrXdUWRSbrYUTy+fEiBbLx
         gfYld/ImbhbhFCAB3CVDV2b6ZwSAIpfsZ03WmaBVYFJweD70DeqLpNjEkLFmWxJGgK0E
         lEqpvoaElurR4V6glouI4BY7MQQ7nJQtgxF75s9EEZDj4llW6XBQJ/csdEpO/zMWtMx2
         PcmYxWo6bew6oqxKyCB5f60SLswrqXFqkCd8NsUKQdH8LnPD33pOn57+2wbMMvkSlW2E
         rUjOQp7LMtNHzD89Pk2DjElaYWklpAWKjwhH1CewQJD0aMiJl0gaHKDLDq0bPQAR7n8g
         LFLg==
X-Gm-Message-State: APjAAAVF0myecDZsjNmyqK/00JmuYHTCBX7d4EyXIERUcD/wfKkzVkdJ
        uIyPG49XLNhx2PF77YCiG3zf8BZOp4U=
X-Google-Smtp-Source: APXvYqxLPllsGZLlxNtEUpBnVXacBqb+gEXDDN272hE95BQSEU8d8/PhZ51akiCWShoJWTk8nIciww==
X-Received: by 2002:a19:c205:: with SMTP id l5mr14090817lfc.159.1582139266396;
        Wed, 19 Feb 2020 11:07:46 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id q14sm267168lfc.60.2020.02.19.11.07.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 11:07:45 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id f24so1015369lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:07:44 -0800 (PST)
X-Received: by 2002:a05:6512:687:: with SMTP id t7mr14685091lfe.30.1582139264476;
 Wed, 19 Feb 2020 11:07:44 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
 <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
 <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
In-Reply-To: <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 11:07:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
Message-ID: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why don't you just use mkdir with S_ISVTX set, or something like that?

Actually, since this is apparently a different filetype, the _logical_
thing to do is to use "mknod()".

Yes, yes, it will require a new case (and maybe a per-filesystem
callback or a flag or something) in "may_mknod()" and "do_mknodat()"
to let those new kinds through, but it sounds like mknod() is actually
what you're doing.

You presumably need a new type _anyway_ for stat() and/or the filldir
d_type field. Or do you always want to make it look exactly like a
directory to all user space?

                  Linus
