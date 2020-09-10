Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42473C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F1521556
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NcxTxOLd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgIJW5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:57:00 -0400
Received: from linux.microsoft.com ([13.77.154.182]:43230 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:56:59 -0400
Received: from [192.168.0.121] (unknown [209.134.121.133])
        by linux.microsoft.com (Postfix) with ESMTPSA id 31FC8210673C;
        Thu, 10 Sep 2020 15:56:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 31FC8210673C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1599778618;
        bh=DlYJOMEzeEFK4Nozie1ZQ0hdzVfQG5TN5yUejRLatBo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NcxTxOLdc5mwFIUAH/FMMCQ/3Vsd5faPDdgm9rUjeXWvMsP4DcYixjDqdEcG9+80z
         9+tXFVEEkTW5KkXzG7vf9ek6K1uD4WyFylEI7gkLPMWNf6RFIis8sYXtg35y3bhycK
         9ZDEH1sresjl8itEZKQJXpg77BBDJaRsDkRjCoJE=
Subject: Re: [[PATCH]] mm: khugepaged: recalculate min_free_kbytes after
 memory hotplug as expected by khugepaged
To:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Allen Pais <apais@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
References: <1599770859-14826-1-git-send-email-vijayb@linux.microsoft.com>
 <20200910220145.5j7iogqulmvg5vr6@black.fi.intel.com>
 <CA+CK2bACLNVqKP9Mgr37HQKOY=7+-PwuLCtqN6+saW7uuiMCfw@mail.gmail.com>
From:   Vijay Balakrishna <vijayb@linux.microsoft.com>
Message-ID: <a153dae8-77c2-f298-0ae5-9956560f9382@linux.microsoft.com>
Date:   Thu, 10 Sep 2020 15:56:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bACLNVqKP9Mgr37HQKOY=7+-PwuLCtqN6+saW7uuiMCfw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/10/2020 3:28 PM, Pavel Tatashin wrote:
> Hi Kirill,
> 
> On Thu, Sep 10, 2020 at 6:01 PM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
>>
>> On Thu, Sep 10, 2020 at 01:47:39PM -0700, Vijay Balakrishna wrote:
>>> When memory is hotplug added or removed the min_free_kbytes must be
>>> recalculated based on what is expected by khugepaged.  Currently
>>> after hotplug, min_free_kbytes will be set to a lower default and higher
>>> default set when THP enabled is lost. This leaves the system with small
>>> min_free_kbytes which isn't suitable for systems especially with network
>>> intensive loads.  Typical failure symptoms include HW WATCHDOG reset,
>>> soft lockup hang notices, NETDEVICE WATCHDOG timeouts, and OOM process
>>> kills.
>>>
>>> Fixes: f000565adb77 ("thp: set recommended min free kbytes")
>>>
>>> Signed-off-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
>>> Cc: stable@vger.kernel.org
>>
>> NAK. It would override min_free_kbytes set by user.
> 
> Hi Kirill,
> 
> Thank you for looking into this. How is this different from when
> khugepaged modifies it?
> 
> echo always >/sys/kernel/mm/transparent_hugepage/enabled
> 
> Which results in:
> 
> start_stop_khugepaged
>    set_recommended_min_free_kbytes
> 
> Which will also adjust min_free_kbytes according to hugepaged requirement?
> 
> This bug that Vijay described is another hot-plug related issue that
> we have found on our system where we perform memory hot add and hot
> remove on every reboot.
> 
> Thank you,
> Pasha
> 

Thanks Kirill for taking a look and spotting it.

IIUC, it is an existing issue, we should fix it while we are at it. 
Otherwise with my propsed patch introduces a regression for hotplug 
memory consumers with THP enabled and min_free_kbytes set by user higher 
than calculated by THP.

Vijay
