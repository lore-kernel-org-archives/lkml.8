Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD071C35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 832B02082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 06:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729145AbgBYGfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 01:35:42 -0500
Received: from relay.sw.ru ([185.231.240.75]:39432 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgBYGfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 01:35:42 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j6Tod-0004kl-UK; Tue, 25 Feb 2020 09:35:36 +0300
Subject: Re: [PATCH 7/7] sysvipc_find_ipc should increase position index
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>
References: <b7a20945-e315-8bb0-21e6-3875c14a8494@virtuozzo.com>
 <8ed2850e-7cec-ebeb-4e15-21da3715c42a@redhat.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <8e097c72-5fd0-4a59-12e3-8298b9f5468e@virtuozzo.com>
Date:   Tue, 25 Feb 2020 09:35:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8ed2850e-7cec-ebeb-4e15-21da3715c42a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,
Could you please pick up this patch?

On 1/24/20 7:26 PM, Waiman Long wrote:
> On 1/24/20 2:03 AM, Vasily Averin wrote:
>> if seq_file .next fuction does not change position index,
>> read after some lseek can generate unexpected output.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  ipc/util.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/ipc/util.c b/ipc/util.c
>> index 915eacb..7a3ab2e 100644
>> --- a/ipc/util.c
>> +++ b/ipc/util.c
>> @@ -764,13 +764,13 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>>  			total++;
>>  	}
>>  
>> +	*new_pos = pos + 1;
>>  	if (total >= ids->in_use)
>>  		return NULL;
>>  
>>  	for (; pos < ipc_mni; pos++) {
>>  		ipc = idr_find(&ids->ipcs_idr, pos);
>>  		if (ipc != NULL) {
>> -			*new_pos = pos + 1;
>>  			rcu_read_lock();
>>  			ipc_lock_object(ipc);
>>  			return ipc;
> 
> Acked-by: Waiman Long <longman@redhat.com>
> 
