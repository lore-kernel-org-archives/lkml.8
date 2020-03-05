Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E803CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0F2820732
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="aGAWUnq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgCEUvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:51:02 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:43781 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgCEUvC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:51:02 -0500
Received: by mail-yw1-f68.google.com with SMTP id p69so52444ywh.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 12:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+KkcNSGG4PmqcHf5w0J/0EA5pqzwTNlZhZPBmrmp7lc=;
        b=aGAWUnq2cShWMA0rCbiRWuVCWELljpX3PB/FsEKGMOFKDXpvVY26swvU1c83ciEV+C
         vZfZPwlp/g4NcEdLGqpe73q7GJanZJzUj1PqzqD+1q/UbfbPfMtPUcBQqEQ1NG/baZT1
         Eg84AfRliEdTYVakSs34OEyTVaJcEodqXgcX/1DW2HbALNbr9n7Pe4axB/UldwC8oIhb
         e+LE398BVASwZokiGAXu+1GIxRuQENdZmZk6VIDtumHXmAfZsZufuaoMj2sBsHbO/Pb+
         hA0XbxlRv5htq2DMEsIiN1fAac252TMiClDppHPRIbUbRR8B1EbMDYwB0KsRmeF5LX2H
         gJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+KkcNSGG4PmqcHf5w0J/0EA5pqzwTNlZhZPBmrmp7lc=;
        b=F82yez/XzGD1fEZl7ey4ofSM0xXBa6pNhIfsA+MG96iNFWzFog+Lx7ddngwrZ1xPeO
         mzMbHxQtOjrA5sIImQuDFZjbqBo7W58WQes+ncMgIHvCbot0jOv5TGg0LjM/YqE8fVXE
         TU1HLrRtBJxUaMZf8mLlqVx7q85FUA+0ABfLqZ8xWxeNHK8VSnbfbrDqn3Ev+gT4fO2N
         CwXCnaL+107sRh5dmmBGq17uZoCGJtOvoH0CprhS4+kNkXK9C5LNmKebjjaUXBUuIJwk
         usbPU3sta7K2HJyKq2qQsxMUww/vllQ0qwmE7n5tBT3cQHzonOLIcYKjoo4j2Pmz41kO
         bzWw==
X-Gm-Message-State: ANhLgQ00IksThRUNTPLZxsvuyV6Bio3PqUwkUqHfaW67YGFv5agE3Rtd
        NYXJSj2Nt7Bp4pgG+pB7AXyAhQ==
X-Google-Smtp-Source: ADFU+vs50RkJRZ4RwwF6XWZXespcdsmaoCqqPgVtO/9DW5s3y9h2GpkJOYvZU+X77or1j5LpSjT7oQ==
X-Received: by 2002:a25:6a45:: with SMTP id f66mr119436ybc.63.1583441461260;
        Thu, 05 Mar 2020 12:51:01 -0800 (PST)
Received: from cisco ([2607:fb90:17d4:133:1002:9a44:e2a2:4464])
        by smtp.gmail.com with ESMTPSA id d203sm10941125ywc.29.2020.03.05.12.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 12:51:00 -0800 (PST)
Date:   Thu, 5 Mar 2020 13:50:54 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        kernel-hardening@lists.openwall.com,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/32: Stop printing the virtual memory layout
Message-ID: <20200305205054.GD6506@cisco>
References: <202003021038.8F0369D907@keescook>
 <20200305150837.835083-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305150837.835083-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 10:08:37AM -0500, Arvind Sankar wrote:
> For security, don't display the kernel's virtual memory layout.
> 
> Kees Cook points out:
> "These have been entirely removed on other architectures, so let's
> just do the same for ia32 and remove it unconditionally."
> 
> 071929dbdd86 ("arm64: Stop printing the virtual memory layout")
> 1c31d4e96b8c ("ARM: 8820/1: mm: Stop printing the virtual memory layout")
> 31833332f798 ("m68k/mm: Stop printing the virtual memory layout")
> fd8d0ca25631 ("parisc: Hide virtual kernel memory layout")
> adb1fe9ae2ee ("mm/page_alloc: Remove kernel address exposure in free_reserved_area()")
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Acked-by: Tycho Andersen <tycho@tycho.ws>
