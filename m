Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F14C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40DE920767
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 07:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s4YcjPoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406571AbgDNHYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 03:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406537AbgDNHXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 03:23:55 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EE9C0A3BDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:23:53 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id di6so46344qvb.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 00:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LcdIxndh6lcpBlcIRMeQO2FwttO4I/tI0/H530utufg=;
        b=s4YcjPoUUkr0TyC6YzTU3dPrS41C6WAZkWaP9CSsdjBofJjkIgUeaWcj3Xu9wYH35b
         0fsxOl7IOaf8Xm/wSf+kAFw293NtA57YSRrJhrUYrX75I0CcSgEQPU/ILXc3ywS6xyTK
         NFkSmTxJxdfn3XFMSuE7SYJmQmkvRmrEA+EyK9zrEDURaq52XhtNYwGqcMGT9es+RTDa
         ZifZ6WHTtXkzTtqw1AqOJwopl4ANttKFvJH1KlxffAJppiA6679/Jrj45QV7AdqHGwq4
         HEdkTrFJ9usxJvcNSlNwSpnkSUvP0cJ9QHy32cLpgn1wxxxvZQaz7XSZ7SSPklxVcAOe
         GyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LcdIxndh6lcpBlcIRMeQO2FwttO4I/tI0/H530utufg=;
        b=s0XLmr/jR8HcHVrP8EeeDE9HlTXZrZluowNrGy0HWP1Dn2c3ZpyXsQxgD0YvLsMCWH
         K9lPGUIsxg96mNAjYnrsfrhVEZt3lsvZoF03SbrdIgiuHr90KzSYYKB/MKnL3XiYg6vT
         ctkW6UBHBJn0ANyALwD/Cn86fsQLgzyXjXAM4knEyaXziQxhFEU6SalQK41DB+yNYrUQ
         M4Wz83erMtukGOINyk43U+fG1E0BRDuOuYVS+JkFtLzQ4VTC0U7QGcFbIehyupG8p9oR
         TNbzO+lZjF1kx8lRC4FrZBHEsCicXI8ujNCUN5gvxluAHEMXYXvs4TJyz6Bup6pOEu82
         7rmw==
X-Gm-Message-State: AGi0Pubn8DRIfBjYXC25g44RxI9d6XCOSIYUjjXqyUT6qjnamc/T+PfA
        tYizR63bzCXH1liARElQ1tNaJxiwKovJBVK+OAsvNNTqNAk=
X-Google-Smtp-Source: APiQypLEWcR/9nOAnR3rHJMMvZh2/LFcSYN9IMjAYF/f7MF/4VHEJD2AkcaZiszYVQMvaEk3fFX2mGzc6J8uZawmRYc=
X-Received: by 2002:a0c:f8cf:: with SMTP id h15mr5119910qvo.22.1586849032152;
 Tue, 14 Apr 2020 00:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000002ce79705a3275559@google.com> <20200413133216.df03bc0a952276abdaa610cd@linux-foundation.org>
In-Reply-To: <20200413133216.df03bc0a952276abdaa610cd@linux-foundation.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 14 Apr 2020 09:23:40 +0200
Message-ID: <CACT4Y+bxX0uotj=jFteBRZH0O3S9LgOK655jLfJLGP+Ef5q_pg@mail.gmail.com>
Subject: Re: WARNING in unaccount_page_cache_page (2)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     syzbot <syzbot+2854d22c7dd957a6519a@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Evan Green <evgreen@chromium.org>,
        Martijn Coenen <maco@android.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 10:32 PM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Mon, 13 Apr 2020 00:50:11 -0700 syzbot <syzbot+2854d22c7dd957a6519a@sy=
zkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    ae46d2aa mm/gup: Let __get_user_pages_locked() return -=
EIN..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12b60343e00=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dca75979eeeb=
f06c2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2854d22c7dd95=
7a6519a
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the comm=
it:
> > Reported-by: syzbot+2854d22c7dd957a6519a@syzkaller.appspotmail.com
>
> (cc's added)
>
> Looks like the loop backing device's pagecache still has a dirty page,
> despite us having just run sync_blockdev().  It may well be a race of
> some form - do we have any description of what the test is doing?


Yes, it's probably loop related. And this is probably a very hard to
trigger race.
Below are the suspect programs that triggered this.
This also happened on upstream before:
https://syzkaller.appspot.com/bug?id=3D77543faae8aa91ae9993d8e0d34df41926b2=
dc8f
And also on ChromeOS 4.19 and one 4.15 tree. But in all cases the rate
is very low and syzkaller was never able to reproduce this. So I would
assume this is a race with an inconsistency window around few
instructions. But I think it is real because over the past year it
happened 14 times and reports are similar each time and the suspect
programs are similar and there are no red flags in these crashes.


03:37:00 executing program 4:
r0 =3D syz_open_dev$loop(&(0x7f00000002c0)=3D'/dev/loop#\x00', 0x0, 0x0)
ioctl$LOOP_GET_STATUS64(r0, 0x4c05, &(0x7f0000000140))
ioctl$LOOP_SET_STATUS(r0, 0x4c02, &(0x7f0000000440)=3D{0x0, {}, 0x0, {},
0x4, 0x0, 0x0, 0x5,
"ac5bf01f087d9b6b2b4ef241994072b427e00bbc53686e5568cea5ee418ce7849ff33833ea=
3fef415b9d29359a45d3f4bed6f4cc492689ec6c293f5300",
"2ad9fecca7cc61acea23c4f3f3fa50d96f78bb5301efaa332caf8d8b649b433f"})
socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000040)=3D{0xffffffffffffffff,
<r1=3D>0xffffffffffffffff})
r2 =3D dup(r1)
ioctl$PERF_EVENT_IOC_ENABLE(r2, 0x8912, 0x400200)

07:38:06 executing program 1:
r0 =3D syz_open_dev$loop(&(0x7f00000000c0)=3D'/dev/loop#\x00', 0x0, 0x0)
memfd_create(0x0, 0x0)
ioctl$LOOP_CHANGE_FD(0xffffffffffffffff, 0x4c00, 0xffffffffffffffff)
ioctl$LOOP_SET_STATUS64(r0, 0x4c04, &(0x7f0000000200)=3D{0x0, 0x0, 0x0,
0x1000000000000100, 0x0, 0x0, 0x0, 0x0, 0x0,
"f8ca781d5f7e93115c52fa936f014904ccdb29372829d175a4e80426585243b3926d887f68=
6449fdd786f718d8343d49d4273cc82ed2a2ef63524fc21d710476",
"92ef27bcf4634f9065ecbc04c983083f390c3d7bf9ac5c11d0b65e00070e98265579146956=
67ee4534b1192353f3f801223d563be035c7fb302fe546973e9c78",
"f1a55947f83b5a8a1bd0d7e25a30c2c9d78038891de2ae1c3c5b7be4da2a17da",
[0x40]})
ioctl$LOOP_GET_STATUS(r0, 0x4c03, &(0x7f0000000080))

19:42:21 executing program 1:
r0 =3D syz_open_dev$loop(&(0x7f0000000180)=3D'/dev/loop#\x00', 0x0, 0x169a0=
1)
socketpair$unix(0x1, 0x1, 0x0, &(0x7f0000000180)=3D{<r1=3D>0xffffffffffffff=
ff})
r2 =3D fcntl$dupfd(r1, 0x0, r1)
r3 =3D open(&(0x7f0000000280)=3D'./file0\x00', 0x0, 0x0)
openat$cgroup_procs(r3, &(0x7f0000000340)=3D'tasks\x00', 0x2, 0x0)
openat$cgroup_int(r3,
&(0x7f00000005c0)=3D'cpuset.memory_spread_page\x00', 0x2, 0x0)
setsockopt$inet_opts(r3, 0x0, 0x4,
&(0x7f00000003c0)=3D"58f10464950edbede8663b501d22a8e6e6f9569b55a8622ecfe3f1=
16891a39b0f1727a97bca3b5e6aacbe237ae175c5913bf8a6233608aaaeb6a3184ff5d41c46=
31dc3d07e43ec5ba0354a16a9f95cabd681dcf0cdca09af7a5e0a49b8a991e7c18fe6a8cff4=
bf5d1bc6d12600302a368fd6be7b5af414d5298312cbeda7aeeec370e65813a432b74fa41e7=
5e75668daf2ced6eea4dd7298132fc87891cbfee1116ebdf77d6679aafeae940497875a516f=
b22b12349d4c05d0765f59a8ed97dfab8bb730022ea1a9f220db620317e4864fe1fd23b7f9b=
df0d2e75042c6e4379758bf5f1a2831abbe7e017fe516f8088136b122255383171f46f5985f=
574def52437fa189361b8d164871a272493f066cc8a24c5c7c4978d62bafa3041f35d9afc03=
91f771555aca132f51ef8fc714695e93d89df7bdf47c7e3ecd090b5b19a7aca5dd7debd4ded=
5fa7f80f878448618e498f836a63ffd181d4653d0e672c85dcac204b7600d258c702b10070b=
1f8b781340bbae19fe8f7f3292574889513cc2ebf0554444fb00acf060499d42f389d8a5510=
409fa1dae491e4e2de79406041b042320be78c0d3f8e51f37f8c228ebcf235cbeed21b883c5=
b3cfe3f7080e8fee7904158e21d9b0b3f1fb3c3fb8b1dd24bc3fcb595355946a64ee1e1177f=
dccdb9725524c68e0546eea7035a46a0326162d8c18008d7c88fd7cefe98d13b09bc102b696=
9c0568e9db9bbdedfd79ae3465ab098484578070cf32d741c174b0e35e050b5ce7f26cb3bec=
ffc46bacac648cfe0ad8150226f2d08e5f021c5a35fa1a2cda971febb873c1e384800b7f16d=
2f0dc9ef635a62e90ff0737ace00fddbebbb97f4df419783fedbae810b55b3110136cd502bb=
a11f630028aaf3c8898aeaa8a9f4afa2778455cea2bf0b5d23a0f26ddfee4a6888a5d95bf53=
a3788983171fc00a719e0bee38e3685c72ef888739c0c18311f23d8b195bdbaed5c3d3836b3=
757e811c74bdc7dae558220d253fa1ab1f8ebd4ebdb2d7317035c3327fb0a2390c95bcaa55c=
9396810964b6d56c96de7b7c0884844c9a3009e591d707cec129f1372d096b9fd6e50728d86=
63033058965a2bc2567c9e5ea2936d301b3888c532c3f2e668c84b731ab0ff1308d6202f2f9=
584c14dd88579e4bb0ed44f073290e4fce5bd69f23d34d2b14e8fdee732523e7c51defcbd73=
6fd09207d91ce062cd0624345c407f6cc2bca74878d91e294ee32a845ccca97063f11618698=
c15d5910ac0d4a5f479d1f6cb04331dc9ecc4fad18091e67d8f1e56cb1cb18f8f9c12d53b6c=
383dc52825d5923902ed4abf0de093ff45902b8444beb50f0bea053d60b5f978b8387c9523a=
a0a5cc06ceeccee30ed35aa893cfd14a5bfcd0e7d9696ba536ed9de9411920c62e10176395c=
06afe83fc462a6fc4af7a41ef9f57829e79629af97f9f2932fd0d7e38ff04d9dfc9e7bce924=
93ebe68d486aaacaf8cc6d48318577dea6d1a39993969e2b221f316c3a6987e87ef9bfdfea5=
bac0ffe0f51f55fcfde907dae613678bbfd263122f96a864f146d4a73d71c905c4a9804d27b=
0233b0f4ea7ba48bd13010d8a4ee6b8f47b461360d5cda585f773cfafd4bc95f06a3884c47b=
392b4cd03c9ede15ddd538c13a1d08caacbaf7a0c4c65a63363a2322bf15fe5a29066948911=
8afa0329a0eb3e4c6180b2e726c57b6d59a70afce599dcb9c4d7f938445fc83ac6ff71ba060=
6e71c8654ebaf41eb586ab3207b4347757d9d896295a2bb4816974618c1adaba37adc14dc72=
9fc9a37e6bed63baec2f43820e5406c7b86bb2d85dba4c12371b15a3235c7c818166ce16595=
9e7d4c8ad53352f04c1366b37c30af6c02cebcb206762e37e53a392acd10cbaa9ea5e5a0a4b=
9fcb22d3a3145653766b6500c6d36be8c3cb4bd71501eb0b7682a18f0d38e1ba8477764166a=
603be01a785130e3505708ba963b10fe37e61bb6947bba691e41baad0906473e95f1f81124c=
ec3dc93b51f9ace0886c912b1c5b5f8acb264e407c8a53603c6349ef82c727515e9421e6d76=
603b66dc57e679d818242088bd12fddcb909fa744baddf2f135e1d124acef8a881f620aa4b3=
df5a8ed99c5d9843075f178319c0a4234c515808bde50d0a0f87128596a7da7e94a0a4d8526=
f01cb7ec8f7219f98a8d512270ca20c0c4866ecfd5cc1f2ad197ffcb7ae295e68ec660d1665=
4abed0045ae3917ebc2550a6b19790521879bd55063c722ef7d7a8065536d59e408167a4ccc=
3730f1cd21d801eb508df8c115d4377c3c095560abc83554cce73cd4adb00580ee879bf71a6=
68dd02c9676d9c0a3d4d335c18ac727def6b8d470603781a82b37d0208498479cae7fe1e752=
2b90f5e23b9496b3d224aeb9fce9b21c83d6e26cdc793c84875cbee1fa8c6cbaeb0baa03a66=
8fef01cf66311f241a985afe2212414fa7ae6a2730641b28d43f01adfc71ad0a552fec332da=
a73b38302c45725ad6970e3146ccaea2afbcf1af0f81fc48c53ad589dcdbee148af4c3b8872=
6b493831032dc23fc26588b2b6bd1558a2527fdf9a8d94564917092df0b9b721a9fbe55dcfc=
4e27528c012f26cf422fb9faa8f46363c0c21ec9093ee37053deb7b1f50104e53096500a955=
a1f8a1a1b31d03f76e6031deec809d09af6247072392d905af3a9c2e5f921ce39e7afff1d04=
9cc6c67162541c397567f063047f87c2ed26565103e42d8d95e391fc2e03a74572bad2f9489=
ccb233e2d3d5238de9a8065c23b4872fb4c03de91e577892666daf526011c94e2669d78304d=
fda2d4e31f01750b3f868276424ddab468fbfb3fc0c0e1580b30b10f615ddc24826c3a4df66=
11d5d0bc9b777cc870f6e5d5bd2ff34cb3b6d875dc329f37e1387b68596e6124730e6be6648=
fff1c43132f76a24f3ed030c7afde94a014384e36a880725da4fff70d5dc28bc376377db3e8=
a878c9293c4ebfb4a85eae8ec2c1132a5184774cbc43ddcba78e44ba06e9aaa375599ad4835=
58df4b0f32b6bc41264d47affc3414bc5d919956ce3eaf8c8f3f6accf0909d0ac490266d8c5=
7cb88e72f0b4e03ab0a04e27400884d167243e1806a69250722983e8a1d73f362a80dfb37fe=
56120bbec0bf86092a3969edfb3f198de0319faf549d3e7752c85bf7cc14e5b15fc5fa148af=
aa7efa330d9810305007a9419aea4c2d6494000114a9d20449288d85b33c169ec19292cb44a=
57fd0b5c0669bf66deec4459f1a27c899b7b400c570f7756d5173718e7c4e14a85b2600d142=
23f82f1bc4bd74fbc5665f555d52374a0f0d3d60f27217577cfed7449c596f8ccf73fb91619=
417a2f26806a3d1f1676bbb3d204ee9b82097ccbb6968fdbcd235527c971148977b24354bf3=
ab5f98e6eefdcbf62dcb9681127322edc14cd51b8180587593cb95639729c32cf1f1f6e4a05=
3e0a2f5b60a18c7494dee4ccb70efe4e7ebda5b2f846d8c04a6ce07c81c4f1bd47ddb818994=
3704d09446c3e671bc1187144dbfd36a68a27190172bd96363dfe536bcc3faf90e83937c27d=
c606fc95b17cc997da506b0944c0694fe8f46904f91bdb9ccb18274d252e9ee081b241c08b8=
0a1a57c3be561c6f7d888843b5e95e50340cca1278dcbedee80682c60b7957e76524bfc1854=
acc92b7fc3b5ff5db0e9065e8367c78a5dd23299b2cf093e1e70e0b193b76733512687304b5=
06e4702331aeea1d774250a32a6f3077aab7c7149bae89d405b22e0cca5bf35a9169152ba3b=
3910a1fb47defa4246846ce8f0f892e2c9c36e57b6525c2976b3c07f5659ddf35487ca12967=
ff6aaffaaaa5da9f6d798d2cf1b57ab27775c810af5fe5c2646c34981e28fb3bfbd0cebda7a=
27b9198a6b901210f8e452a203c685928bafcabe4c8601388fd0fd5965c88e01fc00032d8ff=
07591cfd5fe7491024a64f6124b985d87cd794f51f4575a33ac30685fd22a003e73da56359a=
4087d6acdbb8b098d2973e61650244109b2fe4d3c89dc93fc684b39469df9fdf9348e64d7d1=
212175a788adc45a308f8dda3ac83c9b67af1c997ab215ab1088b6e1cd0baf76192177aa3a1=
1a80d0915f0670de2e56ac75b1c299f8dae63065c787bc426e4786038be99f9000d45842e6c=
2172b7295b72bb4923c2df65c784a043460389c5a8f5c91e966b8d8ea8fcc2d214a9dbf7856=
7722501dac6ba00b8dc5a676143cc9c1d464aaa99cc06a9e6027f32df310e5c322b24d0f345=
e0b5a41f6147c47a0d30895a8f54acd6dcb790a0c85d1e0da53e444c7cf45a6c3ba8fc94299=
8b35e8ad7047064238bf4cd6335c4a935375ce0272f460c9550239c6c028113fc33aaf2ef55=
a1d1907b8570c1ec683a484f41514f67ac90a17723c980b8d6c299da2a269fedac8923151f2=
44fac8d91655c5ad537aa8c394240f652db1ad4cb946f2947832bb730da533763981fe2eb90=
dfc526c38211e971b491d5565325757def9636ab5415ab502659a0273fb52b608246fcfff1b=
81013bea8c1929050c1241dae171f36814bbf1c094bee6d61c36cd1207a698aecc729afa704=
01ee0f3b55295ed2ec059ab3d3ebf84e0c616bf6c997e8ee845331d1f9247dc1b8d7e2dcdb2=
629d277716dded8620d65953383c395a01b388c401278abf0d3bc481cb6735fb84a05aa93d2=
2ba24cc70d5510ebfec9835df4557671f9e1407daa3815ad3a7145e6bcd5f983b2313d7e5c9=
797fe51e2a9eb4d6e70fe488aa19c94ff17169876a0a87a1c3c138159018abcb6808e6d1f12=
ba49e6a02085782a7e3c21af83c6a19a02aa365c541211bf289b47ea605a7ecf323fdd704e5=
744c190ecc6f1c3fb68fb9d70a1cd0f4b5d67cae209a75cd873cb2c10133f408df6897cf7aa=
1538f9b9d55a282e11776fa8c1830302221e2afbec5a397ebe531ac66121b45c67145390788=
0a6838af296f13b47a41d27ee7649481ec9aa3721b443619a6b4458e9e7bae08c614ecd11db=
daf931c355e744045f824f754522ca81a1b7c7c4fa3576d9c71f75b43e556ea8e4398f8cb91=
afedb1d2bbfdf6d2cb8e3f67906d7b6216b43601d5ffa11abc11c83bd4727804a94d019b244=
32ef011e64a5871e23f0a70936265cb72bd6b90052e5518e54259fef63a67455e6be58b917e=
bc54d33a94aba17206dad915e670444116ce7d161f658b90dfe8a29d98c68f962455b949dd9=
0e5c8e29b221957f41eec2da3262c93f2c0c4aaa5cdce84e5da0c281215b9ae069f6a29de1c=
c0dcfc863a305bdbc9427a69e5614aa91c2aa5ab9b09f145e2de6fda28a2533dd6535ff2d7e=
0dc4b9c44f52a533559f4428a564744b9310adf7329d6c55df7eba2dbfd281eaad01b19b098=
45a6a01dd7c5306dd359a83cac453a6a868220da96ebbd67e79adaaf3a6225c08e3aaf789df=
4f1b1c88588b4d916ac85654047c0e9be507d09cdfeec70349221834eb58fbe44d538dba410=
18f0fff632760063384bbb44cdff6c6a2eca357746a9ee63195436be931bc43c91dc670ec03=
4f2bf089f07a90745b64a2c29244954983aa8e620307c050f5849f171ff71f30d9fee4ab501=
36d3eaa26e091e33c8c2ae106797720a283b7cc806f6f3189efc792bcf31469090bdfb6b24d=
4de7dc194d89195ce7d86c2e55309e1141ef6c17fe482868cee0ee16bc6c78d93a6c388e316=
c71cc55015da38d33ff0efa9bab983abba0c0d6410127f0c1dc16752a45540b112771ff91f9=
6e4dd90b57a4abc6d4034e2fc429fb8dca6675f71d96dce661c1a4447c47182d0ee144eacf6=
f501d46bf995c3b9e1d5a41b21dc3902f5ab95",
0x1000)
ioctl$PERF_EVENT_IOC_ENABLE(r2, 0x8912, 0x400200)
r4 =3D open(&(0x7f0000021000)=3D'./file0\x00', 0x0, 0x0)
fchdir(r4)
ioctl$EVENTFD_SET_IPI(r4, 0x40044503, &(0x7f00000000c0)=3D0x68)
r5 =3D getpgid(0x0)
perf_event_open(&(0x7f0000000700)=3D{0x1, 0x70, 0x0, 0x0, 0x0, 0x0, 0x0,
0x50d, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x1, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext, 0x902, 0x0, 0x0,
0x7}, r5, 0xffffffffffffffff, 0xffffffffffffffff, 0x0)
sendmsg$netlink(r4, &(0x7f00000001c0)=3D{0x0, 0x0,
&(0x7f0000000100)=3D[{&(0x7f00000013c0)=3D{0x22c, 0x33, 0x20, 0x70bd2b,
0x25dfdbfc, "", [@nested=3D{0xec, 0x34, 0x0, 0x1, [@typed=3D{0x8, 0x8a,
0x0, 0x0, @pid=3Dr5}, @typed=3D{0xde, 0x15, 0x0, 0x0,
@binary=3D"a6d2ebbbbb9becdad285ba9c0c5ab005dad95422f2cec03154470e2211ad5cc8=
e386ebd56098eeca89bc7fdefa1b266a1352554adae29e885bca321cc2c8bd3521e54859e78=
24c8db678f95cac4a9fd5339c01d6712c30e537ab14c72ad707f581d037893fe9d60bbcddc4=
90d9cdbf51af91508aa7b61febaa0e29d26286f1fec3d52c9a1d26c76685ef06076c8c98e67=
02fe8af1a5ea48571432245c6e19a0d53b0d4f7184234135cd601ef3033ac4bee1a7cdd5e20=
2479c8930214c0177dac2822b769cd631aba915443c862343696f9a8338c47a50bd2c63d"}]=
},
@generic=3D"5a9ac83384db333b59e7893420c038945522563a246c387f29824d0a95643b9=
3ac207c3989b53e296114766777d1080f0c8449a7d6b0447cad",
@typed=3D{0x8, 0x79, 0x0, 0x0, @ipv4=3D@local},
@generic=3D"4d6341bb6185a8b0775f739eb60141a47685e0f21c54e7ba394a5989e895b6b=
3e094207bf1fc843b7ce243d9883f937560c688fe33bfecc6f8a9283095a6445efc62c6ae0d=
11e73ca21e1c86e31b5cf186e55566f3567872cd4572d7f25ea85cc6a7f074b11db56bd8433=
52e057a5f8f425fdd2bf938f15106e5f16b1b4ac1e5285f6f7ee99f1375089274d44a72d64b=
e36ee5be05c24d3f687677c0d5d56d050661af40e65e092e3bc327d36088f7cb54909441fae=
ddab88ed566feb530f145aaee828bef9f1998499dd95fa90c6f80b66122e5c9fdd7a9957ba2=
0e2a52d725c9933b555fa5be28dfbefcff"]},
0x22c}, {&(0x7f0000000000)=3D{0xe8, 0x14, 0x100, 0x70bd2d, 0x25dfdbfe,
"", [@typed=3D{0x8, 0x7f, 0x0, 0x0, @ipv4=3D@local}, @typed=3D{0xb, 0x92,
0x0, 0x0, @str=3D'self\'.\x00'}, @nested=3D{0xc, 0x4e, 0x0, 0x1,
[@typed=3D{0x8, 0x80, 0x0, 0x0, @ipv4=3D@local}]},
@generic=3D"666faabf8e9294fdbd9c3b0ce610a09b3aeba10bc07a45acc34db0e4fa32bd9=
0c51f8e64259696650e525b90c2e57d73bc3c8dfeb25e9539c8c33315d6a3c65f8910ff6765=
ffbad69db4f269809128376724b02e366e9613d7e71f96636ae4fe40688c52ae03bc8ba34b6=
28a8e584f8fff38e1287bb22ad589d3ec79eb6ff853370c8c8890dfa07410b18cd2ecbb800e=
5eb1ea0e6ed4e379b407b59f1bd7be55ebe5e110e87d825d27f542d8b691c1414f990d239b"=
]},
0xe8}, {&(0x7f0000001600)=3D{0x16c, 0x16, 0x1, 0x70bd25, 0x25dfdbff, "",
[@typed=3D{0x8, 0x84, 0x0, 0x0, @uid=3D0xee01},
@generic=3D"66de195d020c1ebb28559ccc2ad3f4c440bfa5cef08aa71899328195a32ce80=
565c7dc3569c902cab16520143b44751d0fdac2e8514411bfcc94281461ffe50da63acd90e9=
71705a3f0a56221bd2e2f09534180279f2d483c48b31724b5c3271eb63aa7ce7255bebd7ae7=
477e7f679bcd0794c9bee19bd4c7a17228de709e11d59f689",
@generic=3D"c4e8590103cbb92763e781919008b8ded15e160c22b3a47cdc6fc458943531d=
e7b977b0b722ff3167ca325601c5e92ccf1cd96a813302223e22b7f7674f045c4",
@typed=3D{0x8, 0x7f, 0x0, 0x0, @u32},
@generic=3D"62add7a9605ef7bb2dd35f8ed88929a7fcae03cee488c3967067178d9297b2a=
142980e6c5266121c15ec8a496e203e198fedaf8b7f664b16e439e50bbfb6a1b314dd8e2b7d=
b61028f9d1cdb4d7594a026c148ccf0a8b7a0207f1f1b74d5c1b04afc84522c2e169047401c=
2e59d381e6534c3ea8b9c4ffeaf4d8f235e7f3a2c1a0a5bc9fabfb2e026"]},
0x16c}], 0x3, &(0x7f0000000140)}, 0x0)
r6 =3D open(&(0x7f0000000280)=3D'./file0\x00', 0x0, 0x0)
openat$cgroup_procs(r6, &(0x7f0000000340)=3D'tasks\x00', 0x2, 0x0)
openat$cgroup_int(r6,
&(0x7f00000005c0)=3D'cpuset.memory_spread_page\x00', 0x2, 0x0)
writev(r6, &(0x7f0000000000), 0x0)
ioctl$LOOP_SET_STATUS64(r0, 0x127f, &(0x7f00000002c0)=3D{0xa00, 0x60000,
0x6000, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
"b4700382000000a9d205dbb3dff5e4fffe7f3bf7f4b83d58820008806f82f06c6513c4f212=
000000000000400000008000",
"f11e99c600575a02b8ad7e545b0000000b870100e5ff0008c19881dabb1d65050440000000=
6f00008f699682431467812a70966500",
"02ddff00eb96b1e2ea00000100000104fff11fdc9541e9000100000000271f00"})

19:23:10 executing program 3:
mkdir(&(0x7f0000000340)=3D'./file0\x00', 0x0)
r0 =3D perf_event_open(&(0x7f000001d000)=3D{0x1, 0x70, 0x0, 0x0, 0x0, 0x0,
0x0, 0x7f, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x1, 0x1, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x2, @perf_config_ext=3D{0x0,
0x8000000fff}, 0x0, 0xffffffff00000000, 0xfffffffc}, 0x0,
0xffffffffffffffff, 0xffffffffffffffff, 0x0)
clone(0x3000000a0160101, 0x0, 0x0, 0x0, 0x0)
mkdir(&(0x7f0000000080)=3D'./file1\x00', 0x160)
ioctl$int_in(r0, 0x0, &(0x7f0000000300)=3D0x5)
r1 =3D openat$vcs(0xffffffffffffff9c, &(0x7f0000000040)=3D'/dev/vcs\x00',
0x10002, 0x0)
statx(r1, &(0x7f00000002c0)=3D'./file0\x00', 0x0, 0x10, &(0x7f0000000680))
mount(0x0, &(0x7f0000000200)=3D'./file0\x00',
&(0x7f0000000180)=3D'sysfs\x00', 0x0, 0x0)
poll(0x0, 0x0, 0xffffffff)
rename(&(0x7f0000000100)=3D'./file1\x00', &(0x7f0000000000)=3D'./file0\x00'=
)
r2 =3D syz_open_dev$sndseq(&(0x7f0000000480)=3D'/dev/snd/seq\x00', 0x0, 0x0=
)
dup2(r0, r2)
memfd_create(&(0x7f00000000c0)=3D'queue1\x00\x00\x00\x00\x00\x00\x00\x001;\=
x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00=
\x00\x06\x00\x00\x00\x00\x00\xcc\xbf}\xdd\x00\x00\x00\x00\x00\x00\x00\x00\x=
00\x00\x00\x00\x00\xb2\x1e\x00',
0x0)
shmctl$SHM_UNLOCK(0x0, 0xc)
syz_open_dev$sndseq(0x0, 0x0, 0x1)
ioctl$SNDRV_SEQ_IOCTL_CREATE_QUEUE(0xffffffffffffffff, 0xc08c5332,
&(0x7f0000000140)=3D{0x0, 0x0, 0x0, 'queue0\x00'})
r3 =3D socket$nl_generic(0x10, 0x3, 0x10)
r4 =3D socket$alg(0x26, 0x5, 0x0)
r5 =3D fcntl$dupfd(r4, 0x0, r3)
ioctl$PERF_EVENT_IOC_ENABLE(r5, 0x8912, 0x400200)
r6 =3D open(&(0x7f0000000400)=3D'./file0\x00', 0x40200, 0x81)
sendmsg$NL80211_CMD_GET_MPP(r6,
&(0x7f0000000600)=3D{&(0x7f0000000540)=3D{0x10, 0x0, 0x0, 0x40}, 0xc,
&(0x7f00000005c0)=3D{0x0}, 0x1, 0x0, 0x0, 0x10}, 0x44)
r7 =3D syz_open_dev$loop(&(0x7f0000000200)=3D'/dev/loop#\x00', 0x0, 0x0)
r8 =3D memfd_create(&(0x7f00000005c0)=3D'\b^\xe1\xe4\x7f\x98\xa9\x87\tmE\xa=
akU.o@\x00\x00\x00\x00\x00\x00\x00\xdc\x939\xb7\x8e\x9aD0f\x99\xb6\xb3\xe1\=
xefv\xfd\x17\xc2)\x1fI\xed\x99^\xcf\x00Y\x8f+\xd4\x00\x00\x00\x00s\x87\xb2\=
xcf\x9d\x02\xcb}\"d\x89\xde(\xdf\x1c\xab\x16\b\x1a\f\xb0\xef}nj\xd5\xb8\xa1=
-A\xe5\xec#kC\x1aX\xe6r\xc6\xb1qK\x97\x99\v\xaa\n\xfc\xd9r\xe6{\xca\xfb\nIT=
\xfc\x89okn\xc9\x93\xe9s\x04\xc2\xefq\xa6\xc9\x06=3D\x1a\xc8\x01^\xa8)LI[\x=
92\x874oHQ#Y\xd0\xcc\xc5\x10\xe1\x02Z\xeaR\'\x05\x81\x8ch',
0x0)
pwritev(r8, &(0x7f0000000340)=3D[{&(0x7f0000000140)=3D'!', 0x1}], 0x1, 0x81=
80d)
ioctl$LOOP_CHANGE_FD(r7, 0x4c00, r8)
ioctl$LOOP_SET_STATUS(r7, 0x4c02, &(0x7f00000001c0)=3D{0x3608, {}, 0x0,
{}, 0x2, 0x0, 0x0, 0x0,
"b04a82706694a7d154c629f75b71a95a8f3b289271c607adb22d4d534f4cf29cff0359ad51=
4d3aa20d7beebc689ab001521f48dc57122f1b38e9e8af694c0d43",
"d66ee438c04045ff21d735bd90f8c3e2c4a016dd0fa49bebf7a08c305bee6fd6"})
set_robust_list(&(0x7f00000003c0)=3D{0x0, 0xfffffffffffffffe,
&(0x7f0000000380)=3D{&(0x7f0000000280)}}, 0x18)
socket$inet_udp(0x2, 0x2, 0x0)



> > ------------[ cut here ]------------
> > WARNING: CPU: 1 PID: 8402 at mm/filemap.c:222 unaccount_page_cache_page=
+0x631/0xd60 mm/filemap.c:222
> > Kernel panic - not syncing: panic_on_warn set ...
> > CPU: 1 PID: 8402 Comm: syz-executor.4 Not tainted 5.6.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 01/01/2011
> > Call Trace:
> >  __dump_stack lib/dump_stack.c:77 [inline]
> >  dump_stack+0x188/0x20d lib/dump_stack.c:118
> >  panic+0x2e3/0x75c kernel/panic.c:221
> >  __warn.cold+0x2f/0x35 kernel/panic.c:582
> >  report_bug+0x27b/0x2f0 lib/bug.c:195
> >  fixup_bug arch/x86/kernel/traps.c:175 [inline]
> >  fixup_bug arch/x86/kernel/traps.c:170 [inline]
> >  do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
> >  do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
> >  invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
> > RIP: 0010:unaccount_page_cache_page+0x631/0xd60 mm/filemap.c:222
> > Code: 02 00 0f 85 3a 06 00 00 48 8b 1b 31 ff 48 c1 eb 03 83 e3 01 48 89=
 de e8 9d 01 e2 ff 48 85 db 0f 84 d9 fb ff ff e8 ff ff e1 ff <0f> 0b 48 b8 =
00 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 80 3c 02
> > RSP: 0018:ffffc90001287688 EFLAGS: 00010012
> > RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc90011a34000
> > RDX: 000000000000ec1b RSI: ffffffff81913191 RDI: 0000000000000007
> > RBP: ffffea0001165dc0 R08: ffff88804a3ce240 R09: fffff9400022cbb9
> > R10: ffffea0001165dc7 R11: fffff9400022cbb8 R12: 0000000000000000
> > R13: ffff8880a3f6bbe0 R14: ffffea0001165dc0 R15: ffffea00022cd088
> >  delete_from_page_cache_batch+0x1a6/0xec0 mm/filemap.c:355
> >  truncate_inode_pages_range+0x58b/0x1760 mm/truncate.c:366
> >  kill_bdev+0xd1/0x100 fs/block_dev.c:87
> >  loop_set_status+0x315/0x1370 drivers/block/loop.c:1272
> >  loop_set_status_old+0x223/0x310 drivers/block/loop.c:1468
> >  lo_ioctl+0x308/0x1410 drivers/block/loop.c:1612
> >  __blkdev_driver_ioctl block/ioctl.c:322 [inline]
> >  blkdev_ioctl+0x25b/0x660 block/ioctl.c:718
> >  block_ioctl+0xf9/0x140 fs/block_dev.c:1996
> >  vfs_ioctl fs/ioctl.c:47 [inline]
> >  ksys_ioctl+0x11a/0x180 fs/ioctl.c:763
> >  __do_sys_ioctl fs/ioctl.c:772 [inline]
> >  __se_sys_ioctl fs/ioctl.c:770 [inline]
> >  __x64_sys_ioctl+0x6f/0xb0 fs/ioctl.c:770
> >  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
> >  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> > RIP: 0033:0x45c889
> > Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f83d100ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007f83d100b6d4 RCX: 000000000045c889
> > RDX: 0000000020000440 RSI: 0000000000004c02 RDI: 0000000000000003
> > RBP: 000000000076bf00 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> > R13: 00000000000003f4 R14: 00000000004c6902 R15: 000000000076bf0c
> > Kernel Offset: disabled
> > Rebooting in 86400 seconds..
> >
> >
> > ---
> > This bug is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this bug report. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/20200413133216.df03bc0a952276abdaa610cd%40linux-foundation=
.org.
