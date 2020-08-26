Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78EDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 793F92072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBYWQN1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgHZAs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:48:59 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44907 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726570AbgHZAs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598402937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uRbJ+F9DYn9taw2FwIRj45K5IBB74D/7SXcc5vcycGY=;
        b=UBYWQN1OYQCnv0mA4+IM1z3piNyDFSpyIkDWp0UgiiI3PzpcngNZd78emoUvSRC432zN4R
        H9PVM/+Jm3N20DKmQa8wL5oH62jExPNnCnkipBl9FKrvcJOlHeCOAxwGSVclFqhIUxxxDp
        qQhPRRo1CF5tKh0sFHfuk/jGyN5VOj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-gu_RSXrGNciDV3sC1kwB_Q-1; Tue, 25 Aug 2020 20:48:55 -0400
X-MC-Unique: gu_RSXrGNciDV3sC1kwB_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3419A1DDF7;
        Wed, 26 Aug 2020 00:48:54 +0000 (UTC)
Received: from llong.remote.csb (ovpn-112-124.rdu2.redhat.com [10.10.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76C2B100238C;
        Wed, 26 Aug 2020 00:48:53 +0000 (UTC)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwg?=
 =?UTF-8?Q?cpu_hotplug_callback?=
To:     Thomas Gleixner <tglx@linutronix.de>,
        "Zhang, Qiang" <Qiang.Zhang@windriver.com>,
        "elver@google.com" <elver@google.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20200820032453.5222-1-qiang.zhang@windriver.com>
 <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com>
 <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>
 <87pn7ewae6.fsf@nanos.tec.linutronix.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <eedc945f-2d48-1dcf-30f3-21e2e1b094f9@redhat.com>
Date:   Tue, 25 Aug 2020 20:48:53 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <87pn7ewae6.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/25/20 7:53 PM, Thomas Gleixner wrote:
> On Tue, Aug 25 2020 at 18:26, Waiman Long wrote:
>> On 8/25/20 12:53 AM, Zhang, Qiang wrote:
>>> When a cpu going offline, we should free objects in "percpu_obj_pool"
>>> free_objs list which corresponding to this cpu.
>> The percpu free object pool is supposed to be accessed only by that
>> particular cpu without any lock. Trying to access it from another cpu
>> can cause a race condition unless one can make sure that the offline cpu
>> won't become online in the mean time.
> It is actually safe because CPU hotplug is globally serialized and there
> is no way that an offline CPU will come back from death valley
> magically. If such a zombie ever surfaces then we have surely more
> serious problems than accessing that pool :)

Thanks for the clarification. I haven't looked into where the callback 
functions are being called so I am not 100% sure.

Cheers,
Longman

