Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600ADC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AF320CC7
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 05:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="k8Wj5gtI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgEIFdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 01:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgEIFdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 01:33:53 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D35BC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 22:33:53 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z1so2100853pfn.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 22:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0tVZiTNJV00e17zVahHUtStPSAxlvLeHPBPhlbfhP3c=;
        b=k8Wj5gtIkK6y5DbY8Sq3ZWZb/TvYnjQ0Vya1ke2i2pdQ3zvR6r9J9i1SlXjUHdcD83
         a1RO9buUipQhrouxTtShRznVFs7EJzdJk2IcOUs0Ua2/Jr6YSV9cJ2VK4M0Y/YE1EYXO
         m9vyJMgOMkWaqVdoYJWSIGhbfLebt/bAVL4PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0tVZiTNJV00e17zVahHUtStPSAxlvLeHPBPhlbfhP3c=;
        b=YF133dpLK5XytFdW4p8VkPJYaA2xsS27mOv9bzGyoQoyuwPXWTmPVjnFrygwINjHUI
         /3Q6l0qZ7NXyEoiIBrANahNl/heU5/27D/wm5FLWr9c5cOyLFpD8MIxDFtmm6xTizpGe
         +Gv/Ef3hrs9f91mvyWmmAl5udO30aovPSes2OFtMAcbVLzh1e329iPOVcODq1uaugTrc
         m0tyhnY1egYQDS0dc/OQ0+5+sI+CyUZprHQOgWgKfUd7zqqO78fcwyRU6g1eInkuv353
         hWpKWt0mo/hSY/rj1HBoPmw4Y1l7LHnx4seooRzw5oUuaOslCGrtmqQWXWTfcg7peIPd
         G5fw==
X-Gm-Message-State: AGi0PuZN7TIQQzK3u0ej3kTU8vp3naOYttTkVWV8+LowIlrl8x30bEIQ
        vkmYM+LIFI0CknQJ2Rjn3EOgvg==
X-Google-Smtp-Source: APiQypJpcMnhuDccGtYxtxqnI842RrcjWR2VUd9W3d3dC9bnsmR7PHOLvcu7rqZOoDo24IQaTUSkOQ==
X-Received: by 2002:aa7:9889:: with SMTP id r9mr6438549pfl.233.1589002433071;
        Fri, 08 May 2020 22:33:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a136sm3532880pfa.99.2020.05.08.22.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 22:33:52 -0700 (PDT)
Date:   Fri, 8 May 2020 22:33:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/6] exec: Set the point of no return sooner
Message-ID: <202005082232.59838F2@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87sgga6ze4.fsf@x220.int.ebiederm.org>
 <87sgga5klu.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgga5klu.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 01:48:13PM -0500, Eric W. Biederman wrote:
> 
> Make the code more robust by marking the point of no return sooner.
> This ensures that future code changes don't need to worry about how
> they return errors if they are past this point.
> 
> This results in no actual change in behavior as __do_execve_file does
> not force SIGSEGV when there is a pending fatal signal pending past
> the point of no return.  Further the only error returns from de_thread
> and exec_mmap that can occur result in fatal signals being pending.
> 
> Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>

Yes, thank you. I'm a fan; this makes the comment above the function a
bit easier to understand, since the very first thing is to set the
point_of_no_return. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
