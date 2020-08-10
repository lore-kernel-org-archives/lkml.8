Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED43C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A2C82065D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="a8927blX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726624AbgHJUpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbgHJUpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:45:18 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA3C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:45:18 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id u128so6363146pfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 13:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=bSPnxn3kyrwVbRID2Yxgnq1PnNVuxdGlfum9Ij0n2vw=;
        b=a8927blXkuuZ77vcJAPIc1fCrs3Z/XvpAT5yK/HJZMyDdd6sPzS44TtPc9CZmzVzgW
         tmYNMFKu3pmkvywv+sYJF46Mo+op2XhIwM/AqPfTWYskr6N0/0njCZ1t55ced7+wZnld
         bmDr8++wf0/rdkT2od5ARNoaV3e/P0ctYt7QqqSNtSSmSddNLSdalBUS7yX5ytRqQTNl
         09G6532ra5wArLu/htXZqbyjCFRy4Xr5PJLQC+8EipSuzPQttCS+jXputk+kAi3Wvgl+
         OdF645lAAl/TnSHN5z0O4AW9D1VsKtvcSrdKOk1nO4akJq7uMajQf6TiApC/XcP4Gmq+
         KhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bSPnxn3kyrwVbRID2Yxgnq1PnNVuxdGlfum9Ij0n2vw=;
        b=Igqk4rwAtg3ksDyCzBiWTSHtxEQ6APH8rBWeQIDyLCZvTD5feFA7AtR/R9nLggw8Or
         dRUPwCvDBnVt51RbFT0wtauGkLAwPWTPwop47Bhjj+dFZZFZjW7kwPG3t0I8Bui2YkW1
         Q7HvfptzyHiq/6OPrR7vk6FP88XqQlHXGlY6ckHtkekeB1wVQXrL/YunxzL6NtkDoDbB
         Y0aLE6iQpGEKG+Ypq+MILoND9YijVJn9/El+sZSuOM21cCzk2voJA5Vsah5+8ySGhxnY
         BON0gV2iErB+SzdXfJGzAubLNkUuRfacfT6Fvbr9RQCC7Wrju7OIdpErCK+lO7Ey+l4p
         2ddg==
X-Gm-Message-State: AOAM530Zz/dllyU4RSHJhCu4b+hfq/1AoO3RZ5pLnF/0fiTV/SCv3Yx7
        H+2zmseuQ4J5sReUaN244CaLLQ==
X-Google-Smtp-Source: ABdhPJxKiSSq6UWiaNnF1Pac7zVqzamjjJOvuEPwlk6vbhwUi47n/I0zTu2dbu7uhLcKtBTPOAFBLQ==
X-Received: by 2002:a63:b0a:: with SMTP id 10mr23515903pgl.166.1597092317352;
        Mon, 10 Aug 2020 13:45:17 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id d1sm397055pjs.17.2020.08.10.13.45.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 13:45:16 -0700 (PDT)
Subject: Re: INFO: task can't die in io_uring_flush
To:     syzbot <syzbot+6d70b15b0d106c3450c5@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
References: <000000000000991ae405ac8beb12@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d458ed96-32f9-edce-a8b1-e9941c6a8ef5@kernel.dk>
Date:   Mon, 10 Aug 2020 14:45:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <000000000000991ae405ac8beb12@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: INFO: task hung in io_uring_flush

-- 
Jens Axboe

