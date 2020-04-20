Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA585C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9922620775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587395224;
	bh=5WBGpq6FyErtmJlwX9IHJEeJVO8glUGFWmkeqnpj3qg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LrcpjgboRC8LdAinZLUpQQJibZbpbz6gkK6fb26vVYbNvZijEFBducwgSZy7ReSYH
	 AIB6Bnew3API4JEIVeIGOoeRoY/wz85Q2cWRaZQCjI037LR0GuSpWPPiOpxfRNbIFH
	 bHheUNUQVdxcrgdEWnXTW0Lyif5sijwJ003KYEUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgDTPHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:07:02 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37468 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730069AbgDTPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:07:02 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so11835492wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:07:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owGb+0hL00o8Fy1H4zbSX1/Jr+lcLsgBQzWgcg0yHN8=;
        b=tKvbNBvn9OrHt5ZSVyml+9De2+6IrGfEF+eh99JslybRuqCsX03xahg4zUSYn+6sU7
         xBE/pOf9CvEzIJ07CBrqAA5SYZECUIsG/iPmnCc4QppWnqWlnlg9yYT0nYKxiDetiYnG
         80DnWtkS+sQFS2d/UHS0UFfPQg5XrykGPJSHmf56FEZNVYfynI0pkR5fvZ3taeSykcxy
         y6zUWMJqVMlSETDZqoz2XILWFrW8i5wciDdqstzmvz/rCso0Dm+FXkWwQVWA75CTpxBM
         fp8s78YZ/hHJYwIH89nD5oBDD5p4EDv43O63O6wd1CvmFdVgNQ+C1MNvKm5E22zN8oLL
         ZP4A==
X-Gm-Message-State: AGi0PuY3eiNTeIWFZVO8VP1noNL9NtAc3t92UdXyiWGuoCpp84E7go6+
        IgRhmXnyQs0XebWX47YEbZ8=
X-Google-Smtp-Source: APiQypKBfWSgISu6VNXcoIm1QQ/+6r9SgMhnCNyFbVKdm2icgGc0gaN7dPIzPKzEdIJ4ZqihDoruGw==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr17785518wmi.178.1587395220282;
        Mon, 20 Apr 2020 08:07:00 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id l6sm1542091wrb.75.2020.04.20.08.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 08:06:59 -0700 (PDT)
Date:   Mon, 20 Apr 2020 17:06:58 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     syzbot <syzbot+a923008018a2d298247b@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: kernel BUG at include/linux/mm.h:699
Message-ID: <20200420150658.GR27314@dhcp22.suse.cz>
References: <0000000000005103e405a3a66ecd@google.com>
 <20200420041533.5304-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420041533.5304-1-hdanton@sina.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 20-04-20 12:15:33, Hillf Danton wrote:
> 
> Sun, 19 Apr 2020 08:28:14 -0700
> > syzbot found the following crash on:
> > 
> > HEAD commit:    8632e9b5 Merge tag 'hyperv-fixes-signed' of git://git.kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=11ac6be0100000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a923008018a2d298247b
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > 
> > Unfortunately, I don't have any reproducer for this crash yet.
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+a923008018a2d298247b@syzkaller.appspotmail.com
> > 
> > raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> > page dumped because: VM_BUG_ON_PAGE(page_ref_count(page) == 0)

This looks like a page reference count underflow. If there is a
reproducer then page_owner might help to tell who was the last owner.
[...]
 
> Flush TLB every chance before we get every thing done.
> 
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1080,8 +1080,8 @@ again:
>  			page_remove_rmap(page, false);
>  			if (unlikely(page_mapcount(page) < 0))
>  				print_bad_pte(vma, addr, ptent, page);
> +			force_flush = 1;
>  			if (unlikely(__tlb_remove_page(tlb, page))) {
> -				force_flush = 1;
>  				addr += PAGE_SIZE;
>  				break;
>  			}
> @@ -1146,10 +1146,9 @@ again:
>  		tlb_flush_mmu(tlb);
>  	}
>  
> -	if (addr != end) {
> -		cond_resched();
> +	cond_resched();
> +	if (addr != end)
>  		goto again;
> -	}
>  
>  	return addr;
>  }
 
This patch doesn't make any sense to me wrt to the above report. What
are you trying to achieve?

-- 
Michal Hocko
SUSE Labs
