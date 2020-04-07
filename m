Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74A3C2BA80
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7B062074B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 20:33:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDGUdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 16:33:18 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:56964 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgDGUdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 16:33:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 97DE21802914F;
        Tue,  7 Apr 2020 20:33:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glass81_56ab4fb76ca51
X-Filterd-Recvd-Size: 2129
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Apr 2020 20:33:15 +0000 (UTC)
Message-ID: <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive
 data objects
From:   Joe Perches <joe@perches.com>
To:     Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc:     linux-mm@kvack.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Date:   Tue, 07 Apr 2020 13:31:16 -0700
In-Reply-To: <20200407200318.11711-1-longman@redhat.com>
References: <20200407200318.11711-1-longman@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 16:03 -0400, Waiman Long wrote:
> For kvmalloc'ed data object that contains sensitive information like
> cryptographic key, we need to make sure that the buffer is always
> cleared before freeing it. Using memset() alone for buffer clearing may
> not provide certainty as the compiler may compile it away. To be sure,
> the special memzero_explicit() has to be used.
> 
> This patch introduces a new kvfree_sensitive() for freeing those
> sensitive data objects allocated by kvmalloc(). The relevnat places
> where kvfree_sensitive() can be used are modified to use it.
[]
> diff --git a/include/linux/mm.h b/include/linux/mm.h
[]
> @@ -757,6 +757,7 @@ static inline void *kvcalloc(size_t n, size_t size, gfp_t flags)
>  }
>  
>  extern void kvfree(const void *addr);
> +extern void kvfree_sensitive(const void *addr, size_t len);

Why should size_t len be required?

Why not do what kzfree does and memset
the entire allocation? (area->size)


