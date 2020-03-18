Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D38C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 796AF20768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T4iITJqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCRNWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:22:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:50676 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbgCRNWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:22:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LsaypGAZUnvAI1TZE+OGrR3tMl8GKyFuC70m1IycQNA=; b=T4iITJqnadHlmlSJpBn5jtzZwK
        EzaLFBc0f+O8PturchX46yaJqKhjP7hrvD9WXHhjZFRjyOyCFAnLIXWxivPcoCqkJ5P3orQ2S0drT
        JcSFFwdD0BiETUuaMZ6rqGbGsFtQGOLcPwi4w0zJIDS8yqpwOFpGjTqf5u99sERe68TitlJtqn/Le
        fQHD6nS0KQj5veWSleRivuK7y3hZq5iB4uooCcPaKcLLVmNDkbZX88Q/LFf7E0VH/UOiKDr3GTeqG
        2JCMvHkgyeLanV1WUuZNiUxsE0BQlvi1PhHYVBSVu8w8AlYN4HhHT2RkEKLJKiUJ5GFlc/OlebDMw
        0A43DIvw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEYe0-0003Lk-6u; Wed, 18 Mar 2020 13:22:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B30EB3010CC;
        Wed, 18 Mar 2020 14:21:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A46C02B4EBA0B; Wed, 18 Mar 2020 14:21:58 +0100 (CET)
Date:   Wed, 18 Mar 2020 14:21:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, jpoimboe@redhat.com
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mhiramat@kernel.org,
        mbenes@suse.cz, brgerst@gmail.com
Subject: Re: [PATCH v2 16/19] objtool: Implement noinstr validation
Message-ID: <20200318132158.GI20730@hirez.programming.kicks-ass.net>
References: <20200317170234.897520633@infradead.org>
 <20200317170910.730949374@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317170910.730949374@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 06:02:50PM +0100, Peter Zijlstra wrote:
> +static int validate_vmlinux_functions(struct objtool_file *file)
> +{
> +	struct section *sec;
> +
> +	sec = find_section_by_name(file->elf, ".noinstr.text");
> +	if (!sec) {
> +		WARN("No .noinstr.text section");
> +		return -1;

And that is a little too agressive, seeing how the current x86_64 kernel
does not include it. I made it a silent exit for now, so as not to break
the build (with patch 20/19 added on).

>  	}
>  
> +	return validate_sec_functions(file, sec);
> +}
