Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA54C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B89A2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="NMge3sl0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgDXEQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:16:51 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18303 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgDXEQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:16:51 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200424041648epoutp020a0b101b395f2b54ce336ae590130b0c~IpmHryRoe2565425654epoutp02n
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 04:16:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200424041648epoutp020a0b101b395f2b54ce336ae590130b0c~IpmHryRoe2565425654epoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587701808;
        bh=Xxaz6tD9bza4jciD/mqZAoysNvynFcYuDnWX77bailQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NMge3sl00COwuholSzFFCrV+LVdUQoXsC+pwo9egpSNBLIPtdiWLVo0azom+eH9Zq
         txbUWjMaB+25iBThn05wljr45NDZ5I3X9M8zCLPGTL3N4lhz/TBueNBrBvuRBuELbQ
         pHCc7SWnfhmxrJiP2sSTxPCsI9t7zSJkv66PCwqE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20200424041647epcas1p47279eb650cdf1beca08f8cd7f04d8f43~IpmHDnNXO2595825958epcas1p4b;
        Fri, 24 Apr 2020 04:16:47 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.160]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 497gq22TNtzMqYlm; Fri, 24 Apr
        2020 04:16:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        79.D7.04648.E2862AE5; Fri, 24 Apr 2020 13:16:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200424041645epcas1p2e5d0c132ebae47d7f6d60d33bf920712~IpmFXBpZU1014810148epcas1p2Q;
        Fri, 24 Apr 2020 04:16:45 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200424041645epsmtrp18afdd0eec1a2845ec05925f205535bff~IpmFV1LrC2183921839epsmtrp1Z;
        Fri, 24 Apr 2020 04:16:45 +0000 (GMT)
X-AuditID: b6c32a37-1f3ff70000001228-30-5ea2682ec055
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        55.86.25866.D2862AE5; Fri, 24 Apr 2020 13:16:45 +0900 (KST)
Received: from [10.253.104.82] (unknown [10.253.104.82]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200424041645epsmtip2baa9db0282471f5ef5465d9d636ebe36~IpmE7sZXO2398923989epsmtip2f;
        Fri, 24 Apr 2020 04:16:45 +0000 (GMT)
Subject: Re: [PATCH v2] mm/vmscan: count layzfree pages and fix
 nr_isolated_* mismatch
To:     Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     mgorman@suse.de, m.szyprowski@samsung.com, mina86@mina86.com,
        shli@fb.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jaewon31.kim@gmail.com,
        ytk.lee@samsung.com
From:   Jaewon Kim <jaewon31.kim@samsung.com>
Message-ID: <5EA2682D.7010307@samsung.com>
Date:   Fri, 24 Apr 2020 13:16:45 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
        Thunderbird/38.7.2
MIME-Version: 1.0
In-Reply-To: <20200423200020.GB46847@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaUwTURD2ddvugtas9ZoQj7qoBAzQWltWI8ZEootXSDTGaAJuYG3RXnYL
        gncCnqCIoIEiBpUQRaTQqoEGNQJGFK8ACV6oRCWKAgoBUVRsuxj5N/PN930zb957BCa/Kw0g
        Ek02zmpiDZTUX3yjLjg0NEx/IVb5qGgCfdZRJqWvONfQGa58RDe7z0rp12XDEvpqfRtO53R3
        ILroXrqELunvwemS6iwx/c4xdulYpu5LD8Zkp3XjTLW9DWecpUeljLP3FM405A2JmfJfnSLm
        xLVSxLgadzN9zhkx/psMi/Ucm8BZFZwp3pyQaNJFUqvWxS2L02iVqlDVQjqCUphYIxdJRa2O
        CV2eaPAMTCmSWUOSB4pheZ4KX7LYak6ycQq9mbdFUpwlwWBRKS1hPGvkk0y6sHizcZFKqZyv
        8TC3GPS5JZW45TGZUpOuPYCuy44hPwLIBZD79anoGPIn5GQVgrLa1pGkF0HumQyxkPQhKLh4
        TvJP8uRwPRIKbgSDdqdUSLoQvBgsFXlZE8mNMHDkJuaNJ5Eroe/SZYmXhJGNCMofvhR7C1Jy
        HvQUnfLZysgQyOnK9gnE5ByoKXb48Mkeo6rCb0jgTID7+e89WoLwI5VwsmCHF8bImZB2vQDz
        +gNZQ0DW4RzMywEyCjq/i4SpJ0LnvWu4EAfAp6xDuMBPQ9CV70JCko6gzXkcCSw1HM986jPC
        yGBwuMMFeBZUDxUiofF46O7PlAi9ZHDkkFygzIX0jv6RbU2D3386RmIGulvvSIRlFYvA1fAF
        O4kU9lFHs486j/1/5yKElaIpnIU36jheZVGPvmIn8j3hkIgqVPF4dS0iCUSNkz2zno+VS9hk
        PtVYi4DAqEmyivZzsXJZApu6i7Oa46xJBo6vRRrPtrOxgMnxZs+HMNniVJr5arWaXqCN0GrU
        1FTZ6VZDrJzUsTZuO8dZOOs/nYjwCziA1m7rndt+pzklJrDwW2dxXtStrRXszpSKD/IlWFCH
        YiCzIfXKg8p5f16t29uSt2ra+6FNKYF6XfGPlrfJz29/LF+eHDTl52DBQOPd6M+ze6O1TeFv
        BlaYMtyS6U3y+13PtHkz7W5XRMv6PZuDsKYxQ1fzHcP77VvpdnwDtnT4YOC+H82UmNezqhDM
        yrN/AUskxOLYAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42LZdlhJXlc3Y1GcQft3WYs569ewWaze5GvR
        vXkmo8XlXXPYLO6t+c9qsfbIXXaLye+eMVosON7CarHs63t2i2U7+1ksHq/nduD2OPzmPbPH
        xOZ37B47Z91l99i0qpPNY9OnSeweJ2b8ZvFY9+cVk0ffllWMHptPV3t83iQXwBXFZZOSmpNZ
        llqkb5fAlTFl2Ub2gnMCFXtazBoYt/J2MXJySAiYSJxvP8IIYgsJ7GCUmPdFESIuI/Hm/FOW
        LkYOIFtY4vDh4i5GLqCS14wSL6e9ZQKpERaIkLj17SI7iC0i4CXxecVKVoiiJUwSJ190MII4
        zAKnGSVmtV1hBaliE9CWeL9gEpjNK6AlMfntRGYQm0VAVWLPkvVgcVGgqavXXWOGqBGUODnz
        CdgVnAIGEhNmF4KEmQXUJf7Mu8QMYctLNG+dzTyBUXAWko5ZSMpmISlbwMi8ilEytaA4Nz23
        2LDAKC+1XK84Mbe4NC9dLzk/dxMjOK60tHYw7ln1Qe8QIxMH4yFGCQ5mJRHeDQ/nxQnxpiRW
        VqUW5ccXleakFh9ilOZgURLn/TprYZyQQHpiSWp2ampBahFMlomDU6qBKaulluPI1Wm5R3/p
        CfPymiwRXX8hMYj7t7iL5yaWGYnsX+8o8J9g1z+7Z6e/zsv7H36fXWioOun5CyXrYvkI+6kc
        7z6mXTsR7zr39ktBDS+2mRPLls87frk+h7Nf5v/nTIFwDsdV56dJ7Ilb0cbqKdz7Zcf3PC2u
        np31D2bZOs1gOFv2w+CqyNvoNNFM78bc62EVsx9zTW2/vb5aS/J0NN/5goRlntnbU5pn6n5J
        Oap/wjTg+p/DkbuPirYXV87Vyt1gy2e0j/9uwkEvWQ7nvZqs7HOsgleYC1dqqmo7f2xZuqD7
        5+9zy9sPzE0wuvX+ddD5V17zVAMjtiVmlck8ZuP/v3bV2vvdRhLZR57MVWIpzkg01GIuKk4E
        AC52eCkaAwAA
X-CMS-MailID: 20200424041645epcas1p2e5d0c132ebae47d7f6d60d33bf920712
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf
References: <CGME20200422084832epcas1p333225f9b6a00c9ce36f5f5d63fe6e3bf@epcas1p3.samsung.com>
        <20200422084815.21913-1-jaewon31.kim@samsung.com>
        <20200422130751.GD358439@cmpxchg.org> <5EA10872.3010500@samsung.com>
        <20200423160546.GA389168@cmpxchg.org> <20200423200020.GB46847@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020년 04월 24일 05:00, Minchan Kim wrote:
> On Thu, Apr 23, 2020 at 12:05:46PM -0400, Johannes Weiner wrote:
>> On Thu, Apr 23, 2020 at 12:16:02PM +0900, Jaewon Kim wrote:
>>>
>>> On 2020년 04월 22일 22:07, Johannes Weiner wrote:
>>>> On Wed, Apr 22, 2020 at 05:48:15PM +0900, Jaewon Kim wrote:
>>>>> @@ -1295,11 +1295,15 @@ static unsigned long shrink_page_list(struct list_head *page_list,
>>>>>  		 */
>>>>>  		if (page_mapped(page)) {
>>>>>  			enum ttu_flags flags = ttu_flags | TTU_BATCH_FLUSH;
>>>>> +			bool lazyfree = PageAnon(page) && !PageSwapBacked(page);
>>>>>  
>>>>>  			if (unlikely(PageTransHuge(page)))
>>>>>  				flags |= TTU_SPLIT_HUGE_PMD;
>>>>> +
>>>>>  			if (!try_to_unmap(page, flags)) {
>>>>>  				stat->nr_unmap_fail += nr_pages;
>>>>> +				if (lazyfree && PageSwapBacked(page))
>>>> This looks pretty strange, until you remember that try_to_unmap()
>>>> could SetPageSwapbacked again.
>>>>
>>>> This might be more obvious?
>>>>
>>>> 			was_swapbacked = PageSwapBacked(page);
>>>> 			if (!try_to_unmap(page, flags)) {
>>>> 				stat->nr_unmap_fail += nr_pages;
>>>> 				if (!was_swapbacked && PageSwapBacked(page))
>>> Hello Johannes, thank you for your comment.
>>>
>>> The name can changed from layzyfree to was_swapbacked.
>>> By the way, did you mean removing PageAnon(page), too? It seems to be OK, though.
>> I can't decide whether PageAnon() makes it clearer or not. But it's
>> not really needed for correctness. So feel free to keep what you had.
> Yub, PageAnon is redundant.
>
>> I would really just at least change bool lazyfree to was_lazyfree,
> It's better.
Thank you both.

Sorry but let me ask again.

Because PageAnon is redundant, let me remove it on checking lazyfree.
Then, I think, was_swapbacked (first suggestion) is better then was_lazyfree (second suggestion),
because it just checks PageSwapBacked(page). And we knows was_swapbacked is used for lazyfree on stat->nr_lazyfree_fail.

If you don't mind let me pick was_swapbacked instead of was_lazyfree
bool was_lazyfree = PageSwapBacked(page);

Thank you

>
>

