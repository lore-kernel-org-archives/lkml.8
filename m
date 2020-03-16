Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609CAC2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E5920679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5Vv3DiQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbgCPWQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:16:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36343 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732766AbgCPWQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:16:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id s5so23293029wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 15:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S8JSIVJc8hBC+f06nZTFPR0p1Zl2SoUOHTZdVV+bVfY=;
        b=A5Vv3DiQIbfRSJv7uqZ5fY3XPteie2VbktlftTTVVWcjL0Amblo3pOEE+jfyt9yZHN
         tE8B976jEnbzlJPjwhTcFZz5UNBBpwmdr15ARC+uTnWr1Daq8aYuvu4mggOoElN4mgt3
         IdnjfVM3aXeiNm9Hoq1XYirqDlPrGAX66tGqb9ZmIhG4IXAQ1X/t1vs4/sTXAfGsGzpf
         loLe4BKtgUDm3IiF4xmThYdk54MZTNljl2wqstzw9eWZnrsnP3tg2GKhtS+qQsLqf6Vj
         AKtvxnuy1QUG1uDE3F+sfjv8q0gEMv8XgwKIQD2tA7z8nTQ7H2DWmI6Rig36QGl7qf4t
         bmzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S8JSIVJc8hBC+f06nZTFPR0p1Zl2SoUOHTZdVV+bVfY=;
        b=S6XlG7Vkiu/fkchjj0Ex6T1omONo3y/AQ0QKbJvCNzsK3ot9YbgDhwIzY1t6wtPToG
         +5wslFZZdZui9jL6yIYjGR9Gy8fqMkHQEKqBdSdEeVRqYw28GuUHWNBaGTiKVcSE5RWX
         MVr2lUCmMAvvdmlnSB+ZbueHXTjM+Y1wdhvibpBE5DGdtkFOV7qFrGaEYQbfG6Lyq6WG
         e345r0rGCLKjp0TPQV2T6YbPzc8fPVYeh6FXoljwC176kLR2KDPMcV2oshLT0B44yMBn
         H9Lqd9hwTJV7HdRsruzvIqe+Bem21YLY7awRoZdrbhLVsmgrSvs5QvIGqhQ9yRUIZkeb
         MnQw==
X-Gm-Message-State: ANhLgQ2ZRAe0EOd9UVIXeiZBSU0Oywv8xfgl4bRUgEwz49z1Nwoz2mCr
        Xh3T+SvaIIaK11h//+XmVxc=
X-Google-Smtp-Source: ADFU+vse1oKkwdvXItJohl4s4XqPs4btnr1psEXCZPSDssQaCTO12dAzDLte2Fwb/Z4L5RV+sy7bZg==
X-Received: by 2002:adf:a483:: with SMTP id g3mr1611117wrb.403.1584397011889;
        Mon, 16 Mar 2020 15:16:51 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id s131sm1305558wmf.35.2020.03.16.15.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 15:16:51 -0700 (PDT)
Date:   Mon, 16 Mar 2020 22:16:51 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
        akpm@linux-foundation.org, david@redhat.com, willy@infradead.org,
        richard.weiyang@gmail.com, vbabka@suse.cz
Subject: Re: [PATCH v5 2/2] mm/sparse.c: allocate memmap preferring the given
 node
Message-ID: <20200316221651.nkif7tdkks5cmlnm@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200316102150.16487-1-bhe@redhat.com>
 <20200316102150.16487-2-bhe@redhat.com>
 <20200316125625.GH3486@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316125625.GH3486@MiWiFi-R3L-srv>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 08:56:25PM +0800, Baoquan He wrote:
>When allocating memmap for hot added memory with the classic sparse, the
>specified 'nid' is ignored in populate_section_memmap().
>
>While in allocating memmap for the classic sparse during boot, the node
>given by 'nid' is preferred. And VMEMMAP prefers the node of 'nid' in
>both boot stage and memory hot adding. So seems no reason to not respect
>the node of 'nid' for the classic sparse when hot adding memory.
>
>Use kvmalloc_node instead to use the passed in 'nid'.
>
>Signed-off-by: Baoquan He <bhe@redhat.com>
>Acked-by: Michal Hocko <mhocko@suse.com>
>Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>


-- 
Wei Yang
Help you, Help me
