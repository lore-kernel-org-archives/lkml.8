Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B969DC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F32E206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 06:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/UuJZsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgA3G5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 01:57:33 -0500
Received: from mail-pf1-f175.google.com ([209.85.210.175]:40116 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgA3G5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 01:57:33 -0500
Received: by mail-pf1-f175.google.com with SMTP id q8so990754pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 22:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=huaVosl53nJpP94v/buh4oiNNpbIxxq4KUuvCVKsRvg=;
        b=Z/UuJZsHzzCP0r8iNe0I5jcgDk7nS7QrCbZrFnip3NLgUewZWXkz4CQ1c/Q1cVT8Q1
         +1GseJSJv2M3+mm4Hwh6Ywqx/ef7eZKb8Ct4LFiHcYQms0xoHXpeBixjapicNSPiDH2Q
         cZUNZMu6GBoHdBdPHOKZ+eLjW4QmBOYTEIjSCnpVEgdDOxp+N0DDFJLfNiZZHVnCAjss
         N2u6mfe98Z5Z7uZ9D1G5imSzIgGg0sdi3sTvRwBxM3ebVM2phop9IIH+wq3wqcaqd5No
         ZW9/7OPeZZ3UgnnBS9HCMoJjQz2PUr+zMfX9wjArH/BUNY7E167G8kLrPt+UOKjHP7P6
         Uv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=huaVosl53nJpP94v/buh4oiNNpbIxxq4KUuvCVKsRvg=;
        b=W9CMXWcxM6AG4Hj61rTDPGlj4r1sX7Wu5C4nPr89uRq4qZ73Zj9vF1ymO1t2E1ZdsX
         1/WNP5gWYb5YFeVh7DPy799XoI24+p/7GA44jbFk311RMB+IkNYw/Zz94tKvsxcNwZT8
         2cQ1PZ/6qVoal1grzuX42eRW7f2Q7osHd+8Y+EPTXtLdxK8AiFliWSOysiZ6G/6pZTIg
         tNFhn56Yt3gsgSuiaP/h+oyZGvNoJk8TqPeMuXOMcaMQxwh60tvgyaqqUzMJ0wnORSO1
         i1CpTD1xDOYB/A8WcR0BF9ZfcvZocBZ08qakeXKlQ9t32DhHPUcwhgpnr2xQYu7T9HBP
         4v3g==
X-Gm-Message-State: APjAAAVRgDZyNlzi9f1p0MdFIoeT58f0C8LEx3+olEtYu55c45CwKIyJ
        8AL4psroGPR4aQurUUQ1994=
X-Google-Smtp-Source: APXvYqyE7G6+WsXmD6yFeRj72KzFz7PcN7/o2vL2fDMibf6sPdxfm++Q7pFYY+JRKgQjAj5Os8ygXw==
X-Received: by 2002:a63:8349:: with SMTP id h70mr3155850pge.396.1580367452803;
        Wed, 29 Jan 2020 22:57:32 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id g8sm4970595pfh.43.2020.01.29.22.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 22:57:32 -0800 (PST)
Date:   Thu, 30 Jan 2020 15:57:30 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: -Wfortify-source in kernel/printk/printk.c
Message-ID: <20200130065730.GG115889@google.com>
References: <20200130021648.GA32309@ubuntu-x2-xlarge-x86>
 <20200130051711.GF115889@google.com>
 <f099965dc5de82fc5fb60ba10371cd9f1aed2d94.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f099965dc5de82fc5fb60ba10371cd9f1aed2d94.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/29 22:39), Joe Perches wrote:
> > > It isn't wrong, given that when CONFIG_PRINTK is disabled, text's length
> > > is 0 (LOG_LINE_MAX and PREFIX_MAX are both zero). How should this
> > > warning be dealt this? I am not familiar enough with the printk code to
> > > say myself.
> > 
> > It's not wrong.
> > 
> > Unless I'm missing something completely obvious: with disabled printk()
> > we don't have any functions that can append messages to the logbuf, hence
> > we can't overflow it. So the error in question should never trigger.
> > 
> > - Normal printk() is void, so kernel cannot append messages;
> > - dev_printk() is void, so drivers cannot append messages and dicts;
> > - devkmsg_write() is void, so user space cannot write to logbuf.
> > 
> > So I think we should never trigger that overflow (assuming that I
> > didn't miss something) message.
> > 
> > In any case feel free to submit a patch - switch it to snprintf().
> 
> and/or make the code depend on CONFIG_PRINTK

console_unlock() still needs to at least up() the console semaphore.
We don't have printk(), but the tty subsystem is still there and serial
consoles and definitely still up and running. So... maybe we can have
two versions of console_unlock().

	-ss
