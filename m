Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0C4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 770E520656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 18:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgFVSRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 14:17:41 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:59990 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730221AbgFVSRk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 14:17:40 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 90ADC467DB;
        Mon, 22 Jun 2020 18:17:31 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/admin-guide
To:     Pavel Machek <pavel@denx.de>
Cc:     corbet@lwn.net, changbin.du@intel.com, masahiroy@kernel.org,
        rostedt@goodmis.org, j.neuschaefer@gmx.net,
        andy.shevchenko@gmail.com, mchehab+samsung@kernel.org,
        logang@deltatee.com, abbotti@mev.co.uk, jacob.e.keller@intel.com,
        colin.king@canonical.com, gregkh@linuxfoundation.org,
        mgreer@animalcreek.com, tytso@mit.edu, jack@suse.cz,
        ebiggers@google.com, tglx@linutronix.de, akpm@linux-foundation.org,
        paulmck@kernel.org, pawan.kumar.gupta@linux.intel.com,
        jgross@suse.com, mike.kravetz@oracle.com, cohuck@redhat.com,
        jacek.anaszewski@gmail.com, alex@alexanderweb.de,
        dwlsalmeida@gmail.com, dsterba@suse.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200621132049.45624-1-grandmaster@al2klimov.de>
 <20200621220432.GA916@amd>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <c776dba2-1be2-9296-cf79-4788a3eddfd0@al2klimov.de>
Date:   Mon, 22 Jun 2020 20:17:30 +0200
MIME-Version: 1.0
In-Reply-To: <20200621220432.GA916@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: +
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 22.06.20 um 00:04 schrieb Pavel Machek:
> Hi!
> 
>> Rationale:
>> Reduces attack surface on kernel devs opening the links for MITM
>> as HTTPS traffic is much harder to manipulate.
> 
>> +++ b/Documentation/admin-guide/README.rst
>> @@ -1,6 +1,6 @@
>>   .. _readme:
>>   
>> -Linux kernel release 5.x <http://kernel.org/>
>> +Linux kernel release 5.x <https://kernel.org/>
>>   =============================================
>>
> 
> You need to add one "=" here, IIRC.
OK, forget this mail thread. I've corrected this and am going to submit 
a replacement patch.

> 									Pavel
> 
