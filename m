Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05C7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939A42077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 09:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="fAutD3cY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgGJJFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 05:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:05:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A153C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:05:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so5589691ljv.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 02:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VUmFAc962e5K337BfXwFy3uOoKxsKlxWlo6RdFjoWeU=;
        b=fAutD3cY5ow4YDV5uFTnEihRtuC7Y68t5bQaAcEGwzsqiN3yEk3pVzn5mMwLm0lOmL
         VSSvAUFBBhFsy6dQskJH1YPZX9Lx3irhJqVRTFkBdnN8OkHOoKmubOCN0Qrt+lsu2KfL
         63RF42ZenfvJ1bMQEXzT4IVxvDFOA2BE2kLwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VUmFAc962e5K337BfXwFy3uOoKxsKlxWlo6RdFjoWeU=;
        b=cJdC3t0NYKG3BMFV1Lr5Dy8OPHHeqLVc3yF8msaS5eLR06VEPyVbnkYPb/eO7UqjGF
         9HoyrqGDoVOUL8GV9PD8RLbskkcmXEepoNEPa95U13ZDObTe00Jz4hRL05LihKrrDXK6
         KHD3ZP1oTQj1d/sKtK7z1fpeZUUtDDqOQmOEvBgG6CKzbd0Dz9ibVXgUhSqwhFhIEz+L
         YuxiqmZutFJDbD5TR1YkNVO7WdJHcL1nGjqmcl2dVvtIWJc9o9z346Sq1Sh++KHTkCGd
         9kPTe34K7l0ov07EKsphsgtpyitW0dJPncZ/8KEr5ZwcEp7g/NTNYQQ1DyRVBBFEuJQD
         yltg==
X-Gm-Message-State: AOAM532F24AIz/Ka8UKH6Y9YA3s1yhKa3cJc+dEoRhSokM4Pa/ha26aA
        8CGZg6oc9kL6kLQqre6ZtuRy3Gob45UbzQfV
X-Google-Smtp-Source: ABdhPJyfIcP/PQ2s2693hklug7eNZqe5piHixI/UWoYEV5w5FplqjvG+6fc9SV7PjhrnOvGJY/ELSw==
X-Received: by 2002:a2e:8e8a:: with SMTP id z10mr30448109ljk.351.1594371914312;
        Fri, 10 Jul 2020 02:05:14 -0700 (PDT)
Received: from [172.16.11.153] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id q1sm1687890lji.71.2020.07.10.02.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 02:05:13 -0700 (PDT)
Subject: Re: [PATCH] kcmp: add separate Kconfig symbol for kcmp syscall
To:     Cyrill Gorcunov <gorcunov@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200710075632.14661-1-linux@rasmusvillemoes.dk>
 <20200710083025.GD1999@grain>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <14b4a1f0-3caf-75e4-600a-3de877a92950@rasmusvillemoes.dk>
Date:   Fri, 10 Jul 2020 11:05:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200710083025.GD1999@grain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2020 10.30, Cyrill Gorcunov wrote:
> On Fri, Jul 10, 2020 at 09:56:31AM +0200, Rasmus Villemoes wrote:
>> The ability to check open file descriptions for equality (without
>> resorting to unreliable fstat() and fcntl(F_GETFL) comparisons) can be
>> useful outside of the checkpoint/restore use case - for example,
>> systemd uses kcmp() to deduplicate the per-service file descriptor
>> store.
>>
>> Make it possible to have the kcmp() syscall without the full
>> CONFIG_CHECKPOINT_RESTORE.
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> I deliberately drop the ifdef in the eventpoll.h header rather than
>> replace with KCMP_SYSCALL; it's harmless to declare a function that
>> isn't defined anywhere.
> 
> Could you please point why setting #fidef KCMP_SYSCALL in eventpoll.h
> is not suitable?

It's just from a general "avoid ifdef clutter if possible" POV. The
conditional declaration of the function doesn't really serve any purpose.

> Still the overall idea is fine for me, thanks!>
> Reviewed-by: Cyrill Gorcunov <gorcunov@gmail.com>

Thank you.

Rasmus


