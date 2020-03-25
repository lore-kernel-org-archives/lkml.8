Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C5CC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1B520658
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="qAan3Byk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCYV7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 17:59:07 -0400
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21107 "EHLO
        sender4-of-o51.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727374AbgCYV7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 17:59:07 -0400
X-Greylist: delayed 904 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 17:59:05 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1585172614; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=ZSORfTBkrOkN85glZk0NRuP90SGMFU3eASh0QZ4AT2ROVTsclV3AkjiEIsJ2E4lm7uMShrL2QjehzEJXMCkq6njoULLjJCPvgcDPkdSUcQMDmZc2tBHrqZJ4yWY73aamqFjtcGiusjOinVy9iex5A4angQ+VPDV7dXiTXWoyQ1c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585172614; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=6ikTch8JDQ5LCNbBZkc5GMGLLK5g7Wz1EeJzLn7t/oM=; 
        b=drirh98/sh92TmZmSwvhRedZPfTvwUQqENN7wUY+UPKG/2KkODB5zacGaRJWaAmCKX3AWcMv19AkYq9TqRynwafWw2YBga/kTzl65tJgawqHBANA7hhsftxEAEc6FdzuI0UZNY9FmKIWsrT0QD9QDpq8naHFfUkpStuLqzSV1Aw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=apertussolutions.com;
        spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
        dmarc=pass header.from=<dpsmith@apertussolutions.com> header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585172614;
        s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=6ikTch8JDQ5LCNbBZkc5GMGLLK5g7Wz1EeJzLn7t/oM=;
        b=qAan3BykwaGrJssTaprfaWUUDZ4kK9eYLf0Zu7RbQAbhV1bq3ZrrYuA5MtLZPAm5
        /I6GE6tEDBImsJ3kHytqm1yhUbqU9aREfhM8OfqROCQicemEMx89DJ28X3XLn8WEunp
        kn+2HIvv2QljqXpNTc+/Q57jn63yjNALbIimnuLs=
Received: from [10.10.1.24] (c-73-129-47-101.hsd1.md.comcast.net [73.129.47.101]) by mx.zohomail.com
        with SMTPS id 1585172612264530.4678071564699; Wed, 25 Mar 2020 14:43:32 -0700 (PDT)
Subject: Re: [RFC PATCH 10/12] x86: Secure Launch adding event log securityfs
To:     Matthew Garrett <mjg59@google.com>,
        Ross Philipson <ross.philipson@oracle.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, trenchboot-devel@googlegroups.com
References: <20200325194317.526492-1-ross.philipson@oracle.com>
 <20200325194317.526492-11-ross.philipson@oracle.com>
 <CACdnJuvkrMCbOwqkWUOZunXmu1AwfRpjNp3OAfqR2y0O+OK5Fw@mail.gmail.com>
From:   "Daniel P. Smith" <dpsmith@apertussolutions.com>
Message-ID: <38ab048a-f2b0-9778-d9ce-c15374abde94@apertussolutions.com>
Autocrypt: addr=dpsmith@apertussolutions.com; prefer-encrypt=mutual; keydata=
 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
Date:   Wed, 25 Mar 2020 17:43:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CACdnJuvkrMCbOwqkWUOZunXmu1AwfRpjNp3OAfqR2y0O+OK5Fw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/20 4:21 PM, Matthew Garrett wrote:
> On Wed, Mar 25, 2020 at 12:43 PM Ross Philipson
> <ross.philipson@oracle.com> wrote:
>>
>> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>>
>> The late init functionality registers securityfs nodes to allow fetching
>> of and writing events to the late launch TPM log.
>=20
> Is there a reason we would want this exposed separately from the
> regular event log, rather than just appending it there?

We created a separate securityfs node as the intent is to eventually
expose additional information relating to state of the Dynamic Launch.
We only implemented the log node as it is the only node we required for
demonstrating the initial capability. By no means are we tied to this
path for the log. If maintainers would like to see the DRTM log be
colocated with the SRTM log, we can move the logic over to the tpm
driver's eventlog code.


>> +static ssize_t sl_evtlog_write(struct file *file, const char __user *bu=
f,
>> +                               size_t datalen, loff_t *ppos)
>> +{
>=20
> What's expected to be writing to this?
>=20

We want to support a multitude of use cases but for an initial
demonstrator it was felt better to emulate the way people are using
Intel TXT, via tboot as an intermediate loader in the boot chain. When
using a Secure Launch for an intermediate loader implementation, the
implementer has the richness of the user-space runtime for collecting
measurements. As a result they may want(be forced) to do the hashing in
user-space and since this is a measurement that is part of the DRTM
chain it needs to get appended to that log. Thus it seemed natural to
enable the extending of the log by allowing one to write to the log's
securityfs node.

V/r,
Daniel P. Smith

