Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FC6C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029DC20709
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="si63vvCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbgDKN4n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:56:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39612 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgDKN4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 09:56:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id p10so5223643wrt.6;
        Sat, 11 Apr 2020 06:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0HPAHahYAQGlzoLYgXtzlxsXkNFun+xx6JrId2I04YY=;
        b=si63vvCBYvdKsYsBVeAsyrf7ysXXpHRt6vHXXNoUu/JvtOAJLVP5phHL6iHyPbv1k9
         TrgeJPcLaZkdoPZW9PIKhr2+pzblitFxElzBhd0Oi7Cu9fYsHg2/FFZnoKg9+wRq9EVb
         xM4XuUpI/n+78ZoKtBl9OzId/Yo6JeeABzKuvzMGar+pVFgcHG4S82q3OaRZbbS8aeCb
         geoJjPrLeV8kqLVCcDtG0fO0y+1Whc8ZIbzs/eb2UBOUn4E6VvvvqN+RPWlQpjq8zvon
         Ozz2wefNOdYOtaa5x1nu1ABXQakgwIVZAQ8OLx41QCQ5PRj6wFLFUdedEL58K37C2kYg
         KBgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0HPAHahYAQGlzoLYgXtzlxsXkNFun+xx6JrId2I04YY=;
        b=elrwZBfHvV71TcJUtC9DFosnCEqUYRjkjc5Dir/vdeyh6ehOLZWi1H2ipZwRXW/71M
         yBygPr2mZiwDcVwRioiueElMpHiWi6V6Z6lJpsLCy53VyY0NBcYtkzoSzpeeyaoIGiSW
         eCWEPS5QlZvO2dEObISgH7paXdsxYUNnenLEY6PUrIxL1iqcIF34LpG/6CciRWPlZ5SL
         n1X+Z+Ag2IsYzy6DVmrRb3jzwnRA/YxYKLlQX0xxVFdHFbrRTPcAWl/+bLzPhUNc+Sy5
         4NIoPLZlzJzmPTRclTxpq39JLC1FoA0lYB2aWdmQ0Y+vSyijFoosagWSQ6CpFQb38oP5
         88/Q==
X-Gm-Message-State: AGi0PubVza07VLzMNr3tIYMrmwo0VaZ4H7h+3Y9LoM8L4aXgmv7FPwy9
        Zv+piy1ty3MXPj9uaqv4CnA=
X-Google-Smtp-Source: APiQypJxdgTfGuuX+f4Ee56mZ11rjBVKzNcnxYXlcornkz9wCaUiFNB5OrRtpjSciaq5gtl5FcCOfA==
X-Received: by 2002:adf:cc81:: with SMTP id p1mr1042081wrj.372.1586613401053;
        Sat, 11 Apr 2020 06:56:41 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v186sm6812436wme.24.2020.04.11.06.56.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 11 Apr 2020 06:56:40 -0700 (PDT)
Date:   Sat, 11 Apr 2020 13:56:39 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] XArray: entry in last level is not expected to be a
 node
Message-ID: <20200411135639.qn36v6e4bcgc3lnz@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200330123643.17120-1-richard.weiyang@gmail.com>
 <20200330123643.17120-6-richard.weiyang@gmail.com>
 <20200330124842.GY22483@bombadil.infradead.org>
 <20200406012453.tthxonovxzdzoluj@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406012453.tthxonovxzdzoluj@master>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:24:53AM +0000, Wei Yang wrote:
>On Mon, Mar 30, 2020 at 05:48:42AM -0700, Matthew Wilcox wrote:
>>On Mon, Mar 30, 2020 at 12:36:39PM +0000, Wei Yang wrote:
>>> If an entry is at the last level, whose parent's shift is 0, it is not
>>> expected to be a node. We can just leverage the xa_is_node() check to
>>> break the loop instead of check shift additionally.
>>
>>I know you didn't run the test suite after making this change.
>

Matthew

Have you got my mail?

>Well, I got your point finally. From commit 76b4e5299565 ('XArray: Permit
>storing 2-byte-aligned pointers'), xa_is_node() will not be *ACURATE*. Those
>2-byte align pointers will be treated as node too.
>
>Well, I found another thing, but not sure whether you have fixed this or not.
>
>If applying following change
>
>@@ -1461,6 +1461,11 @@ static void check_align_1(struct xarray *xa, char *name)
>                                        GFP_KERNEL) != 0);
>                XA_BUG_ON(xa, id != i);
>        }
>+       XA_STATE_ORDER(xas, xa, 0, 0);
>+       entry = xas_find_conflict(&xas);
>        xa_for_each(xa, index, entry)
>                XA_BUG_ON(xa, xa_is_err(entry));
>        xa_destroy(xa);
>
>We trigger an error message. The reason is the same. And we can fix this with
>the same approach in xas_find_conflict().
>
>If you think this is the proper way, I would add a patch for this.
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me
