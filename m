Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4964DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2763120730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbgAPTtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:49:24 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:56709 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729331AbgAPTtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:49:24 -0500
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id DC94C240002;
        Thu, 16 Jan 2020 19:49:19 +0000 (UTC)
Subject: Re: [PATCH] powerpc: Do not consider weak unresolved symbol
 relocations as bad
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        linux-next@vger.kernel.org, Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
References: <20200115204648.7179-1-alex@ghiti.fr>
 <20200116103932.2e603cf9@canb.auug.org.au>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <ed319b1f-c6f4-7bad-f946-6c01fb202c7c@ghiti.fr>
Date:   Thu, 16 Jan 2020 14:49:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200116103932.2e603cf9@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 1/15/20 6:39 PM, Stephen Rothwell wrote:
> Hi Alexandre,
>
> Thanks for sorting this out.  Just a few comments below.
>
> On Wed, 15 Jan 2020 15:46:48 -0500 Alexandre Ghiti <alex@ghiti.fr> wrote:
>>   
>>   # Have Kbuild supply the path to objdump so we handle cross compilation.
>                                              ^
> "and nm"
>
>> +# Remove from the bad relocations those that match an undefined weak symbol
>> +# which will result in an absolute relocation to 0.
>> +# Weak unresolved symbols are of that form in nm output:
>> +# "                  w _binary__btf_vmlinux_bin_end"
>> +undef_weak_symbols=$($nm "$vmlinux" | awk -e '$1 ~ /w/ { print $2 }')
>> +
>> +while IFS= read -r weak_symbol; do
>> +	bad_relocs="$(echo -n "$bad_relocs" | sed "/$weak_symbol/d")"
>> +done <<< "$undef_weak_symbols"
> This is not a bash script, and the above is a bashism :-(
> Also, my version of awk (mawk) doesn't have a -e option.
>
> How about something like :
>
> undef_weak_symbols=$($nm "$vmlinux" | awk '$1 ~ /w/ { print $2 }')
> if [ "$undef_weak_symbols" ]; then
> 	bad_relocs="$(echo "$bad_relocs" | grep -F -w -v "$undef_weak_symbols")"
> fi
>
> Or do this near the top and add the grep to the others.

Yes that's quite better, thanks, I'll send a new version tomorrow.

Thanks again,

Alex

