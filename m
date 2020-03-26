Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B08C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C70A20714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgCZADw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:03:52 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:45848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727420AbgCZADv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:03:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 8B54A249C;
        Thu, 26 Mar 2020 00:03:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scent12_42e45f963938
X-Filterd-Recvd-Size: 1862
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 00:03:48 +0000 (UTC)
Message-ID: <f97d9dc54178e4344512bc7986265f101f4639c6.camel@perches.com>
Subject: Re: [PATCH v7 2/2] tty: add rpmsg driver
From:   Joe Perches <joe@perches.com>
To:     Jiri Slaby <jslaby@suse.cz>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        xiang xiao <xiaoxiang781216@gmail.com>
Date:   Wed, 25 Mar 2020 17:01:57 -0700
In-Reply-To: <ec061c30-eace-1df9-fa7b-71a61e5710a2@suse.cz>
References: <20200324170407.16470-1-arnaud.pouliquen@st.com>
         <20200324170407.16470-3-arnaud.pouliquen@st.com>
         <e458f805-c746-c88e-98f4-d874a7552933@suse.cz>
         <1e4ce821-dd9b-bb04-774b-58a255834cf5@st.com>
         <ec061c30-eace-1df9-fa7b-71a61e5710a2@suse.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-03-25 at 14:31 +0100, Jiri Slaby wrote:
> The question was exactly about that: can a compiler optimize it to a
> bare number or will strlen call remain there?

$ cat str.c
#include <string.h>

int foo(void)
{
	return strlen("abc");
}

$ gcc -c -O2 str.c
$ objdump -d str.o
str.o:     file format elf64-x86-64


Disassembly of section .text:

0000000000000000 <foo>:
   0:	f3 0f 1e fa          	endbr64 
   4:	b8 03 00 00 00       	mov    $0x3,%eax
   9:	c3                   	retq   


