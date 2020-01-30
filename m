Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2EDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55E0B20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 14:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgA3Oiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 09:38:55 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60446 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3Oiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 09:38:55 -0500
Received: from [109.134.33.162] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1ixAy5-0001c1-DG; Thu, 30 Jan 2020 14:38:53 +0000
Date:   Thu, 30 Jan 2020 15:38:53 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 03/17] follow_automount(): get rid of dead^Wstillborn code
Message-ID: <20200130143853.ferv2mtgwka5q4lx@wittgenstein>
References: <20200119031423.GV8904@ZenIV.linux.org.uk>
 <20200119031738.2681033-1-viro@ZenIV.linux.org.uk>
 <20200119031738.2681033-3-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200119031738.2681033-3-viro@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 03:17:15AM +0000, Al Viro wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> 
> 1) no instances of ->d_automount() have ever made use of the "return
> ERR_PTR(-EISDIR) if you don't feel like mounting anything" - that's
> a rudiment of plans that got superseded before the thing went into
> the tree.  Despite the comment in follow_automount(), autofs has
> never done that.
> 
> 2) if there's no ->d_automount() in dentry_operations, filesystems
> should not set DCACHE_NEED_AUTOMOUNT in the first place.  None have
> ever done so...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

I can't speak to 1) but code seems correct:
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
