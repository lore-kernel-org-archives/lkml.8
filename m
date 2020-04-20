Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83C1C38A30
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:23:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CC6218AC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJbYcDGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgDTKXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:23:13 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55973 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725773AbgDTKXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587378189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mgfTqPWpI28qJPKQRS6dma5CrISAimpMlANceCOogUg=;
        b=TJbYcDGU2QbjjMfS0h7iTGUWbgToq+Fr1MojJsD2aW4iGFYgMA+MWAJ5wfa+DPSgWnR1Se
        OOnvbXVWb/P01pOauKU3ouOdPK14RolINSY+atNrerD9JfYP8IRllTJSISGhdXrllaq1Ha
        IHUaquGHU1fNLhwhge8TzKnRoR9VaKU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144--ub4mz19P3K9Jq7Nj2RhOg-1; Mon, 20 Apr 2020 06:23:07 -0400
X-MC-Unique: -ub4mz19P3K9Jq7Nj2RhOg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B329013F8;
        Mon, 20 Apr 2020 10:23:06 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 46F8160C84;
        Mon, 20 Apr 2020 10:23:00 +0000 (UTC)
Subject: Re: [dm-devel] [PATCH 0/3] dm raid/raid1: enable discard support when
 any devices support discard
To:     Paul Wise <pabs3@bonedaddy.net>, dm-devel@redhat.com
Cc:     Mike Snitzer <snitzer@redhat.com>, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>
References: <20200419073026.197967-1-pabs3@bonedaddy.net>
 <20200419131908.GA22398@redhat.com>
 <9cb6a39a43178be29af2f47a92c2e84754b62b69.camel@bonedaddy.net>
 <6bbf9d94-2fbb-f96f-ea85-a480ba109c55@redhat.com>
 <a0034feda1f6f598c8376a418949b48109307e67.camel@bonedaddy.net>
From:   Ondrej Kozina <okozina@redhat.com>
Message-ID: <6e458e2a-f8aa-d6e3-0e6d-7c11ad2a6825@redhat.com>
Date:   Mon, 20 Apr 2020 12:22:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <a0034feda1f6f598c8376a418949b48109307e67.camel@bonedaddy.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/20 12:13 PM, Paul Wise wrote:
> On Mon, 2020-04-20 at 09:35 +0200, Ondrej Kozina wrote:
> 
>> Did you have discard allowed on both dm-crypt devices? dm-crypt
>> (kernel) does not allow discards by default.
> 
> I did not, I guess that explains why I got no errors.
> 

FYI if you use LUKS2 metadata format for encrypted drives, you can 
enable discards by default once and for all by following command:

cryptsetup open /dev/sdx sdx_unlocked --allow-discards --persistent

Any following unlock will enable discards automatically.

Regards O.

