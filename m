Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8ECC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4841722B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 20:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdFjDSdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgBRT6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:58:46 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45543 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgBRT6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:58:41 -0500
Received: by mail-ot1-f68.google.com with SMTP id 59so20767945otp.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UOjwYHMvf6TltZqdhvtIaC6UvMCiDEeSqOQKVNxR6Jw=;
        b=qdFjDSdPBN7d8V4wjLswZbCZ8j6D+/gzu7dsqRJj8R62FEIeH3CROCJtzhhme6sB8u
         CHGTzfOe+ZKEJELX/mWqA3iSFHkYKHCVOTRQz0X6CGiEelH0Zt/xuZLjHJTM6t6b0XL1
         RJ41UEk5BtQVNBsUsOfqg6wndpZvhf4ZfZyXKN6oDPRvo5HIX8XSFLIN0B4m/JFhuo/6
         i1kbC6P1sVaJVWepPrVOST7eGdLyyd8KUHic0KuA2Z304/N97cypZX+BqUcAyrT2Jd4j
         BNzE8o/FzkhOdoE4u2lvq1yINp5QOGqQKHWES5C+nlFQ4LkUxqaINpOzCF+fF4NKwFBD
         FuGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UOjwYHMvf6TltZqdhvtIaC6UvMCiDEeSqOQKVNxR6Jw=;
        b=CjO2WeZlCt0sXPhTC2lGi0mXUMwGlNglhQfb6A+X7RopTSjPSAGnPhe2z7VqxsIjX4
         iYZQr9zEyK9OQg5eiRvBlc10wHCjXgzFpqeNsLxal3kri3TWkx3JbfTDzKbepbLoYVbv
         tTGjNK0NI2sgQ5j1IdjdWRFv7QdDkcoJCnzBqxKwB7nRZwplT6/NfW+IL9LQ+BK/RTny
         tDVfOFnqGnDZwdAp9hcKWmG8qXZ9DyNcGQOjqgYdUm/8+iFRXpFBjX4jagUCXFmeVMha
         Tw28CPQYmdaON1aZbV35Q16JF88jB/vH5XyM9a6TovehAbwJGCFZrOgbjE7BL0or3DkJ
         rKhQ==
X-Gm-Message-State: APjAAAVaCNMOQBl+s5hD1JNiv7Ju6zv1zCeadsAEFrd1MK5GQTXOOIp0
        91RgjGT2yalKRBBsRcmgGjM=
X-Google-Smtp-Source: APXvYqzj1NAurGmfJwU5eZJRKQXu+5B/l1iUa0sbt6uTBSlPHsFQEhwNlpnYX38qDv9GVqEzftm84w==
X-Received: by 2002:a05:6830:1d8b:: with SMTP id y11mr17774948oti.4.1582055920527;
        Tue, 18 Feb 2020 11:58:40 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id i20sm1687995otp.14.2020.02.18.11.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Feb 2020 11:58:40 -0800 (PST)
Date:   Tue, 18 Feb 2020 12:58:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 2/2] objtool: Improve call destination function detection
Message-ID: <20200218195838.GA8061@ubuntu-m2-xlarge-x86>
References: <cover.1581997059.git.jpoimboe@redhat.com>
 <0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a7ee320bc0ea4469bd3dc450a7b4725669e0ea9.1581997059.git.jpoimboe@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 09:41:54PM -0600, Josh Poimboeuf wrote:
> A recent clang change, combined with a binutils bug, can trigger a
> situation where a ".Lprintk$local" STT_NOTYPE symbol gets created at the
> same offset as the "printk" STT_FUNC symbol.  This confuses objtool:
> 
>   kernel/printk/printk.o: warning: objtool: ignore_loglevel_setup()+0x10: can't find call dest symbol at .text+0xc67
> 
> Improve the call destination detection by looking specifically for an
> STT_FUNC symbol.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/872
> Link: https://sourceware.org/bugzilla/show_bug.cgi?id=25551
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Tested with clang-11 and binutils 2.34, a combo that was previously
broken and I no longer see these warnings on either defconfig or
allyesconfig.

Tested-by: Nathan Chancellor <natechancellor@gmail.com>
