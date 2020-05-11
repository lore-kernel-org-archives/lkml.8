Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6176BC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3008D20720
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 14:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589207226;
	bh=wA/woHgg7KScDqgGUDSMuZm7P5JxTqQGPF8V2VE68uM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jQTlBjQv0UXMgHQUDia8VLGeg9B6V2DXBNvu9b52KxjJYHgvcFw4zGY2jSj98AtQ6
	 lKuHoklgOs+gavWytFjg+NmxvcqqW5eu/Bnx8RiEQ3jDXjKLNRObr19LSNn8MA4iMZ
	 XbpbBkGqZxM3QP8fkDFM58bVw08uZs0VTLkh98L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbgEKO1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 10:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725993AbgEKO1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 10:27:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEBBC061A0C;
        Mon, 11 May 2020 07:27:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id b1so7263043qtt.1;
        Mon, 11 May 2020 07:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xQIMMWmkmzNPu5lBxwc6esCz5frrLfz7ITsHgCO5zBs=;
        b=WZYuEsND7nPWq2Ociq595u+4iPmO5a8oFBQAFb2TxtO5zI5rGx3QRCRYKN9hb4kp4Q
         ZXfHUeXHVagWoZ1lPNLUl3vf+c3ikWiKkWqCv9s7iHSMbi1AZGJk1Qfrol29ppAg5Mwm
         NqwcZwZTfFAWpKNmzNN5qxIMnDfDFuhduNH8B8RIoHxW2eXHlQTGBcTvGdL8SUfp6GqN
         WWdGnqWtT0Co9WGjW29SEOI9W+QW9yzUinmtJ4UZsZ+GL/OxkxlfF5eCmmPDhlY7qf6t
         n8DPw1DlX7gfduX4bA54od3KtG9qR/eKPiwQH9KJLiVaw9/orm6V2+5e4JSbVf6E0LS4
         2T8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xQIMMWmkmzNPu5lBxwc6esCz5frrLfz7ITsHgCO5zBs=;
        b=ANjNBAai5bmWuamYvFHJik5k7DonraEf2YeW2PR1bEmmMCiwhmQT2jyd8guKlxz0Eb
         kcIMGZfltcA85y58LbrxCuLJX+fEbVPzBcEYztA/yyLDaM6L0uGHIIA5Q7x5TAJDu0/k
         QorVpW7bnkaGvI348uqN/VNbQ5uVqV/ew3hp2K/GWRJDURf5qEHTgz/pnWGQMFUB79cv
         IxVtlzPCY/zVRFGd7ZN174KuPyxDqbLHrgBjE7a/XM/1gd0X73dV//7/EZ1RVoE+qntF
         Syr8JwxJFSkkJWh5pr/lS9OfuXJZQT0VhkCLe5L2cZKEBbVatiTqS1Z8oLodvOOMU9H7
         f/zg==
X-Gm-Message-State: AGi0Pua4jNYDuARYQalBEXoZ9swdl2WbGp5yFj5OamubyvOpAS9+qiT/
        QzU6/OnBh4z6hgzRBtdV4Ogr8chJ74Y=
X-Google-Smtp-Source: APiQypJIIaf9khQucTgkaHqPimOAkk9DYKCGhIcuGyXRB5i5RTGaYiM/ULDO7vjSmWwpIlfC8nXYhA==
X-Received: by 2002:ac8:7b8e:: with SMTP id p14mr17416133qtu.219.1589207223754;
        Mon, 11 May 2020 07:27:03 -0700 (PDT)
Received: from localhost ([199.96.181.106])
        by smtp.gmail.com with ESMTPSA id y28sm3625959qtc.62.2020.05.11.07.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 07:27:03 -0700 (PDT)
Date:   Mon, 11 May 2020 10:27:01 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Sean Fu <fxinrong@gmail.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] workqueue: Fix an use after free in init_rescuer()
Message-ID: <20200511142701.GC16815@mtj.duckdns.org>
References: <20200508150740.GA415175@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508150740.GA415175@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 06:07:40PM +0300, Dan Carpenter wrote:
> We need to preserve error code before freeing "rescuer".
> 
> Fixes: f187b6974f6df ("workqueue: Use IS_ERR and PTR_ERR instead of PTR_ERR_OR_ZERO.")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied to wq/for-5.8. Thank you.

-- 
tejun
