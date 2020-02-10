Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C63C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2EA2085B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KN8qiFp9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgBJQiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:38:55 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39606 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgBJQiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:38:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7H8noUeVpdgkfhQLFQRvLg7PR9W5hFNXA/e1nm7hpqw=; b=KN8qiFp9uHk9veBRyS2+w3DGM1
        F8/W9rfVYx8X70dqZJErerYQMQbVdcEtklif+UiCBbjP+l/6mFaNYZkc2/bwR/GVIiaGM9alcAj92
        Vkb+5RGQUu3rK9aYhaEJU/YLfofNDO7GR9Zvdv2/Pyc50Dke0nEPoqjB/YPaTWmbIZc9U07ccSe2P
        zL8XmsCXU7rkuEQD43kRd5V1O/BfkNGodxVWTJTht4cZpHGpM1o87Y/4DTUwME2N4ZBLXjNumigvt
        LmdGcUGiCa06M9lAt9bUr99f9jyBArMJuY98mw8Z2srZ2lC4haF7NF9S0+iUjooyGQjZ8lsXqjVi0
        0cTQL1YQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1C59-000785-OT; Mon, 10 Feb 2020 16:38:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AC23530066E;
        Mon, 10 Feb 2020 17:36:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C1F32B8ACE83; Mon, 10 Feb 2020 17:38:43 +0100 (CET)
Date:   Mon, 10 Feb 2020 17:38:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        sean.j.christopherson@intel.com
Subject: Re: Checkpatch being daft, Was: [PATCH -v2 08/10] m68k,mm: Extend
 table allocator for multiple sizes
Message-ID: <20200210163843.GL14897@hirez.programming.kicks-ass.net>
References: <20200131124531.623136425@infradead.org>
 <20200131125403.882175409@infradead.org>
 <CAMuHMdWa8R=3fHLV7W_ni8An_1CwOoJxErnnDA3t4rq2XN+QzA@mail.gmail.com>
 <20200207113417.GG14914@hirez.programming.kicks-ass.net>
 <CAMuHMdW8hWpSsf31P0hC=b23GCx4oFwfaVYKQ1qrZfwFCPK5-Q@mail.gmail.com>
 <20200207123035.GI14914@hirez.programming.kicks-ass.net>
 <20200207123334.GT14946@hirez.programming.kicks-ass.net>
 <3f8a8a2f89bfd2d4cca9ac176ef41abf3a0ed4ab.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8a8a2f89bfd2d4cca9ac176ef41abf3a0ed4ab.camel@perches.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2020 at 10:24:15AM -0800, Joe Perches wrote:
> Maybe this?

This isn't anywhere near RFC compliant, but I do think it greatly
improves the current situation, so:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

one little nit below..

> ---
>  scripts/checkpatch.pl | 39 +++++++++++++++++++++++++++++----------
>  1 file changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f3b8434..17637d0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1132,6 +1132,7 @@ sub parse_email {
>  	my ($formatted_email) = @_;
>  
>  	my $name = "";
> +	my $name_comment = "";
>  	my $address = "";
>  	my $comment = "";
>  
> @@ -1164,6 +1165,10 @@ sub parse_email {
>  
>  	$name = trim($name);
>  	$name =~ s/^\"|\"$//g;
> +	$name =~ s/(\s*\([^\)]+\))\s*//;
> +	if (defined($1)) {
> +		$name_comment = trim($1);
> +	}
>  	$address = trim($address);
>  	$address =~ s/^\<|\>$//g;
>  
> @@ -1172,7 +1177,7 @@ sub parse_email {
>  		$name = "\"$name\"";
>  	}
>  
> -	return ($name, $address, $comment);
> +	return ($name, $name_comment, $address, $comment);
>  }
>  
>  sub format_email {
> @@ -1198,6 +1203,23 @@ sub format_email {
>  	return $formatted_email;
>  }
>  
> +sub reformat_email {
> +	my ($email) = @_;
> +
> +	my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
> +	return format_email($email_name, $email_address);
> +}
> +
> +sub same_email_addresses {
> +	my ($email1, $email2) = @_;
> +
> +	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
> +	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
> +
> +	return $email1_name eq $email2_name &&
> +	       $email1_address eq $email2_address;

strictly speaking only _address needs be the same for the whole thing to
arrive at the same inbox, but I suppose that for sanity's sake, this
comparison makes sense.

> +}
