Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E82C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2AD2467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 08:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgB0Ir3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 03:47:29 -0500
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:48967 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgB0Ir3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 03:47:29 -0500
Received: from [109.168.11.45] (port=43056 helo=[192.168.101.73])
        by hostingweb31.netsons.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <luca@lucaceresoli.net>)
        id 1j7EGN-009anX-4W; Thu, 27 Feb 2020 09:11:20 +0100
Subject: Re: [PATCH v2] of: overlay: log the error cause on resolver failure
To:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200225164540.4520-1-luca@lucaceresoli.net>
 <f9565679-5892-bcf0-f751-bfcac87670a8@gmail.com>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <40fdf0f2-85a4-9f84-6994-a59b7b56cec4@lucaceresoli.net>
Date:   Thu, 27 Feb 2020 09:11:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <f9565679-5892-bcf0-f751-bfcac87670a8@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca+lucaceresoli.net/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

On 26/02/20 04:53, Frank Rowand wrote:
> On 2/25/20 10:45 AM, Luca Ceresoli wrote:
>> For some of its error paths, of_resolve_phandles() only logs a very generic
>> error which does not help much in finding the origin of the problem:
>>
>>   OF: resolver: overlay phandle fixup failed: -22
>>
>> Add error messages for all the error paths that don't have one. Now a
>> specific message is always emitted, thus also remove the generic catch-all
>> message emitted before returning.
>>
>> For example, in case a DT overlay has a fixup node that is not present in
>> the base DT __symbols__, this error is now logged:
>>
>>   OF: resolver: node gpio9 not found in base DT, fixup failed
>>
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> ---
>>
>> I don't know in detail the meaning of the adjust_local_phandle_references()
>> and update_usages_of_a_phandle_reference() error paths, thus I have put
>> pretty generic messages. Any suggestion on better wording would be welcome.
> 
> If you have not read the code to understand what the meaning of
> the errors are, you should not be suggesting changes to the error
> messages.
> 
> Only one of the issues detected as errors can possibly be something
> other than an error either in the resolver.c code or the dtc
> compiler -- a missing symbol in the live devicetree.  This may
> be because of failing to compile the base devicetree without
> symbols, depending on a symbol from another overlay where the
> other overlay has not been applied, or depending on a symbol
> from another overlay where the other overlay is applied but
> the overlay was not compiled with symbols.  (Not meant to be
> an exhaustive list, but it might be.)  Thus the missing
> symbol problem might be fixable without a fix to kernel
> code.  The error message philosophy for overlay related
> errors is to minimize error messages that help diagnose
> the precise cause of a kernel code bug, with the intent
> of keeping the code more compact and readable.  When a
> bug occurs, debugging messages can be added for the
> debug session.

Got it, sorry about that.

> Following this philosophy, only the message in the second
> patch chunk is ok.

Then I think you can apply the v1 patch which only contains the message
about the problem I experienced, and which was caused by an incorrect DTO:

https://patchwork.ozlabs.org/patch/1243987/

Just ignore the note saying the patch is not for mainline, it's wrong.

-- 
Luca
