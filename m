Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D88C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29B0E24650
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582696323;
	bh=adrQAt83Jz1VYJQR0Ydtz4tKVFHlHwdEBeI/YBS3ymM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Rz/kVJh7g/tGdaOWYV1Aro7TrnjmZ/vWUYY7tdrf4MgaqdWgzM7XztJc+CVx5EKui
	 sRF9eTpJl9//ZxGfuOCL4lob4IUPypKmnRETMfRmolt/1qmTqSOuTQo5LZ1VOEH0mO
	 6JGPLUriSbn87ACo48nhfnNSXmath6TQoWFAK3Y0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgBZFwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:52:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgBZFwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:52:01 -0500
Received: from [192.168.0.217] (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA33F206E2;
        Wed, 26 Feb 2020 05:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582696321;
        bh=adrQAt83Jz1VYJQR0Ydtz4tKVFHlHwdEBeI/YBS3ymM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=vsQd00aKR+6P4r5gOMoVfbMk6ondEC5mSm/2hSJS7W1hIYh83hmJMf9EKPEEgSic1
         6BaE9Gp4pYu3B1R6w18sTIElDLFHDWd/4GUAjo7eSOHnnIL6TsKJwuKzzubQSdBKLp
         Q645Km4twIMAN/R7ohTt4wRlvvnsjj7phdpN1+1A=
Subject: Re: [patch 01/24] x86/traps: Split trap numbers out in a seperate
 header
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.285655538@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <3083fa19-8eec-0902-d4fe-7274f420f373@kernel.org>
Date:   Tue, 25 Feb 2020 21:52:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.285655538@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:16 PM, Thomas Gleixner wrote:
> So they can be used in ASM code. For this it is also necessary to convert
> them to defines. Will be used for the rework of the entry code.
> 

Reviewed-by: Andy Lutomirski <luto@kernel.org>
