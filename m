Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97558C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F6062072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598256251;
	bh=DurwqCvIW/hzINDepD8UEE5gX1xPHea/nFwxgHFTxrs=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=qQdlLmjbtEKwGR3u9q5G4NMqOflI7CEk3Jl5/oHpNoETRz0GZYTq1/F8svaVhrtAP
	 RKIxqA0xUgydBDCYaAwCnVWxQCpbVLxUdC6rOZvhtTgNOFhO/XoCzYtXZsZhncj8fy
	 aee07/nI5sMYb16NWUz4APijOnmZRJQW5QPyPam0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726449AbgHXIEK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:04:10 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:38410 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgHXID7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:03:59 -0400
Received: by mail-ej1-f68.google.com with SMTP id oz20so5727641ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 01:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+JxMlzs2Xjqv7gCLfj6qZjcFZ65L/LTwJbVU5rgXZ+8=;
        b=DqzJScITpsVRLV3VuEO2HMYtUHQJvf0e/iXCMrHyv+Wlvneqc4IwOw95+JPIcJRjO/
         T6HQOALeKkfiTqhvWtXIiRoMsLLfxkiVp5cRohA5jZX2aVIatpK/xmzskk9gz9lk2afj
         VQ5EOQPCcJqtKS/m98kt2Z9fpVwZji2nCisK4eWpoXXfHYoRcCt/fH4BjwQfM6KSL0GT
         Ggy8cpRkjByKsG3TDKleGwsVNPn5ZMKTw8bwBCxHEok0YIxd++3OYVk77qZWcsXnwTsI
         Fhs7I/sXhOe4M+dnJUYucOgmRSELiQI4PDJ78WIPpdKI7Ryg3qcL4Myqp94uwKiNhQMk
         jsaw==
X-Gm-Message-State: AOAM531+t7M5kaJP1pa6HGQHUjCz/IuP9CIXOJiuL4ZzBILr0wmINhz7
        jXIfo0h7oTKJaopR5yDjSWc=
X-Google-Smtp-Source: ABdhPJz2NYNLj1EXQEATEwC2xTPip9yHbslDGnx5qa6pEvVHobaKUucPr+DX+qOYSxI69J3OeCO0rg==
X-Received: by 2002:a17:906:22c9:: with SMTP id q9mr4540417eja.158.1598256237043;
        Mon, 24 Aug 2020 01:03:57 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id a19sm8890477ejg.116.2020.08.24.01.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 01:03:55 -0700 (PDT)
Subject: Re: KASAN: use-after-free Write in vcs_read
To:     syzbot <syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        jslaby@suse.cz, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nico@fluxnic.net, syzkaller-bugs@googlegroups.com
References: <0000000000005d511305ad725632@google.com>
 <c432d894-eae6-1541-0f29-267b4a16b3ae@kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2e94ac46-7f0c-c322-d217-afe021214eaf@kernel.org>
Date:   Mon, 24 Aug 2020 10:03:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <c432d894-eae6-1541-0f29-267b4a16b3ae@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 08. 20, 9:34, Jiri Slaby wrote:
> On 22. 08. 20, 9:31, syzbot wrote:
>> syzbot has bisected this issue to:
>>
>> commit b1c32fcfadf5593ab7a63261cc8a5747c36e627e
>> Author: Jiri Slaby <jslaby@suse.cz>
>> Date:   Tue Aug 18 08:57:05 2020 +0000
>>
>>     vc_screen: extract vcs_read_buf_header
> 
> It's like 7th e-mail about the very same issue. Can it be
> suspended/acknowledged somehow?
> 
>> Reported-by: syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com
> 
> I haven't managed to find the root cause on Fri yet, I will chase it on
> Mon again.

Ah, I see now. And the easiest way of handling this is simply revert the
commit now, re-think and redo during the next merge window.

There are two issues with the patch:
1) vcs_read rounds the 'count' up to an even number. So if we read odd
bytes from the header (3 in the reproducer), the second byte of
(2-byte/ushort) write to temporary con_buf won't fit. It is because with
the patch applied, we only subtract the real number read (3 bytes) and
not the whole header (4 bytes).

2) in this scenario, we perform unaligned accesses now. 2-byte/ushort
writes to odd addresses. Due to the same reason as above.

So Greg, could you revert with the above reasoning? It reverts cleanly.
Or do you want me to send a revert?

thanks,
-- 
js
suse labs
